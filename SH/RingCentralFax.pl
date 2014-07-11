#!/usr/bin/perl
use strict;
use warnings;
use URI::Escape;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

### RingCentral FaxOut API documentation availalbe at
### http://service.ringcentral.com/faxoutapi/

my $RC_API_URL = "https://service.ringcentral.com/faxapi.asp";

my $RCUsername = "1857294";
my $RCPassword = "718100";
my $restFax = "1718410";
my $attachment = ["C:/Users/Dog/Documents/order.doc"];


my $request =	POST "$RC_API_URL",
				Content_Type => 'multipart/form-data',
				Content      =>	[	Username =>"$RCUsername",
									Password =>"$RCPassword",
									Recipient=>"$restFax",
									Coverpage=>'None',
									Resolution=>'Low',
									Attachment=> $attachment
									];

my $useragent	= LWP::UserAgent->new();
my $response = $useragent->request( $request );
my $result = $response->content;

print "$result \n";