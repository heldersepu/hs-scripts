#!/usr/local/bin/python
##########################################################################
# pymail - a simple console email interface client in Python; uses Python
# POP3 mail interface module to view POP email account messages; uses
# email package modules to extract mail message headers (not rfc822);
##########################################################################

import os
import sys
import poplib
import smtplib
import email.Utils
import urllib2
from email import Encoders
from email.Parser  import Parser
from email.Message import Message
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
from email.MIMEMultipart import MIMEMultipart

popmailserver = 'pop.googlemail.com'
smtpservername = 'smtp.googlemail.com'
mailuser   = 'getpage123@gmail.com'
mailpswd   = ''
mailfile   = os.path.join(os.path.expanduser("~"), "emailFile.txt")


class SmartRedirectHandler(urllib2.HTTPRedirectHandler):
    def http_error_301(self, req, fp, code, msg, headers):
        result = urllib2.HTTPRedirectHandler.http_error_301(
            self, req, fp, code, msg, headers)
        result.status = code
        return result

    def http_error_302(self, req, fp, code, msg, headers):
        result = urllib2.HTTPRedirectHandler.http_error_302(
            self, req, fp, code, msg, headers)
        result.status = code
        return result

class DefaultErrorHandler(urllib2.HTTPDefaultErrorHandler):
    def http_error_default(self, req, fp, code, msg, headers):
        result = urllib2.HTTPError(
            req.get_full_url(), code, msg, headers, fp)
        result.status = code
        return result

def inputmessage( ):
    import sys
    From = raw_input('From? ').strip( )
    To   = raw_input('To?   ').strip( )   # datetime hdr set auto
    To   = To.split(';')
    Subj = raw_input('Subj? ').strip( )
    print('Type message text, end with line="."')
    text = ''
    while True:
        line = sys.stdin.readline( )
        if line == '.\n': break
        text += line
    return From, To, Subj, text

def sendmessage( ):
    From, To, Subj, text = inputmessage( )
    send_email(From, To, Subj, text)

def send_email(From, To, Subj, text, attachment=None):
    msg = MIMEMultipart()
    msg['From']    = From
    msg['To']      = To
    msg['Subject'] = Subj
    msg['Date']    = email.Utils.formatdate( )    # curr datetime, rfc2822
    msg.attach( MIMEText(text) )
    if attachment:
        part = MIMEBase('application', "octet-stream")
        part.set_payload(attachment)
        Encoders.encode_base64(part)
        part.add_header('Content-Disposition', 'attachment; filename="page.htm"')
        msg.attach(part)

    server = smtplib.SMTP_SSL(smtpservername)
    server.login(mailuser, mailpswd)
    try:
        failed = server.sendmail(From, To, str(msg))   # may also raise exc
    except Exception as inst:
        print('Error - send failed')
        print(type(inst))
        print(inst.args)
        print(inst)
    else:
        if failed: print('Failed: %s' % failed)

def connect(servername, user, passwd):
    print('Connecting to ' + servername + '...')
    server = poplib.POP3_SSL(servername)
    server.user(user)               # connect, log in to mail server
    server.pass_(passwd)            # pass is a reserved word
    print(server.getwelcome( ))      # print(returned greeting message
    return server

def loadmessages(servername, user, passwd, loadfrom=1):
    server = connect(servername, user, passwd)
    try:
        print(server.list( ))
        (msgCount, msgBytes) = server.stat( )
        print('There are ' + str(msgCount) + ' mail messages in ' + str(msgBytes) + ' bytes')
        print('Retrieving:')
        msgList = []
        for i in range(loadfrom, msgCount+1):         # empty if low >= high
            print(i)                                  # fetch mail now
            (hdr, message, octets) = server.retr(i)   # save text on list
            msgList.append('\n'.join(message))        # leave mail on server
        print("")
    finally:
        server.quit( )                                # unlock the mail box
    assert len(msgList) == (msgCount - loadfrom) + 1  # msg nums start at 1
    return msgList

def deletemessages(servername, user, passwd, toDelete, verify=1):
    print('To be deleted: ' + str(toDelete))
    if verify and raw_input('Delete?')[:1] not in ['y', 'Y']:
        print('Delete cancelled.')
    else:
        server = connect(servername, user, passwd)
        try:
            print('Deleting messages from server.')
            for msgnum in toDelete:                 # reconnect to delete mail
                server.dele(msgnum)                 # mbox locked until quit( )
        finally:
            server.quit( )

def autorespond(msgList):
    for msgtext in msgList:
        msg = Parser( ).parsestr(msgtext, headersonly=True)
        if msg['Subject'].endswith('getpage') and (msg['From'] != mailuser):
            for msgLine in msgtext.split('\n'):
                if msgLine.startswith('http'):
                    print(msgLine)
                    html = ''
                    try:
                        oa = getpage(msgLine)
                    except Exception:
                        html = 'error=Can not connect to: ' + msgLine
                    if hasattr(oa, 'status'):
                        if oa.status != 200:
                            html = 'error=' + str(oa.status) + ' Can not connect to: ' + msgLine
                    if html == '':
                        html = oa.read()
                    send_email(mailuser, msg['From'], 'RE: ' + msg['Subject'], msgLine, html)

def getpage(strurl):
    request = urllib2.Request(strurl)
    request.add_header('User-Agent', 'Mozilla/5.0')
    #request.add_header('Accept-encoding', 'gzip')
    opener = urllib2.build_opener(SmartRedirectHandler(), DefaultErrorHandler())
    return opener.open(request)

def showindex(msgList):
    count = 0                                # show some mail headers
    for msgtext in msgList:
        msghdrs = Parser( ).parsestr(msgtext, headersonly=True)
        count   = count + 1
        print('%d:\t%d bytes' % (count, len(msgtext)))
        for hdr in ('From', 'Date', 'Subject'):
            try:
                print('\t%s=>%s' % (hdr, msghdrs[hdr]))
            except KeyError:
                print('\t%s=>(unknown)' % hdr)
            #print('\n\t%s=>%s' % (hdr, msghdrs.get(hdr, '(unknown)')
        if count % 5 == 0:
            raw_input('[Press Enter key]')  # pause after each 5

def showmessage(i, msgList):
    if 1 <= i <= len(msgList):
        print('-'*80)
        msg = Parser( ).parsestr(msgList[i-1])
        print(msg.get_payload( ))            # print(s payload: string, or [Messages]
       #print(msgList[i-1]              # old: print(s entire mail--hdrs+text
        print('-'*80)                    # to get text only, call file.read( )
    else:                               # after rfc822.Message reads hdr lines
        print('Bad message number')
def savemessage(i, mailfile, msgList):
    if 1 <= i <= len(msgList):
        file = open(mailfile, 'a')
        file.write('\n' + msgList[i-1] + '-'*80 + '\n')
        file.close()
    else:
        print('Bad message number')

def msgnum(command):
    try:
        return int(command.split( )[1])
    except:
        return -1   # assume this is bad

helptext = """
Available commands:
i     - index display
l n?  - list all messages (or just message n)
d n?  - mark all messages for deletion (or just message n)
s n?  - save all messages to a file (or just message n)
m     - compose and send a new mail message
a     - autorespond
q     - quit pymail
?     - display this help text
"""

def interact(msgList, mailfile):
    showindex(msgList)
    toDelete = []
    while 1:
        try:
            command = raw_input('[Pymail] Action? (i, l, d, s, m, q, a, ?) ')
        except EOFError:
            command = 'q'

        # quit
        if not command or command == 'q':
            break

        # autorespond
        elif command[0] == 'a':
            autorespond(msgList)

            # index
        elif command[0] == 'i':
            showindex(msgList)

        # list
        elif command[0] == 'l':
            if len(command) == 1:
                for i in range(1, len(msgList)+1):
                    showmessage(i, msgList)
            else:
                showmessage(msgnum(command), msgList)

        # save
        elif command[0] == 's':
            if len(command) == 1:
                for i in range(1, len(msgList)+1):
                    savemessage(i, mailfile, msgList)
            else:
                savemessage(msgnum(command), mailfile, msgList)

        # delete
        elif command[0] == 'd':
            if len(command) == 1:
                toDelete = range(1, len(msgList)+1)     # delete all later
            else:
                delnum = msgnum(command)
                if (1 <= delnum <= len(msgList)) and (delnum not in toDelete):
                    toDelete.append(delnum)
                else:
                    print('Bad message number')

        # mail
        elif command[0] == 'm':                # send a new mail via SMTP
            sendmessage( )
            #execfile('smtpmail.py', {})       # alt: run file in own namespace

        elif command[0] == '?':
            print(helptext)
        else:
            print('What? -- type "?" for commands help')
    return toDelete

if __name__ == '__main__':
    print('[Pymail email client]')
    msgList = loadmessages(popmailserver, mailuser, mailpswd)     # load all
    autorespond(msgList)
    print('Bye.')
