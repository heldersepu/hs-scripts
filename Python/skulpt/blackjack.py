# Mini-project #6 - Blackjack

import simplegui
import random
import math

# initialize some useful global variables
in_play = False
outcome = ""
score = 0
WIDTH = 900
HIGHT = 600
INIT_POS = [800, 110, 8.7]
DEAL_POS = [-100, 100, 9]
LAED_POS = [999, 100, 9]
SEPARATR = [800, 110, 8.6]
start = False
doReduce = False
showName = True
shuffling = True
bust = False
isRunningAnimation = True
message = ""
shake = 0
PlayerPoints = 0
DealerPoints = 0


card_back = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/card_back.png")
# load card sprite - 949x392 - source: jfitz.com
card_imgs = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/cards.jfitz.png")


# Latin Suited cards
class LatinSuitedCard:
    SUITS = ('C', 'S', 'H', 'D')
    RANKS = ('A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K')
    VALUES = {'A':1, '2':2, '3':3, '4':4, '5':5, '6':6, '7':7, '8':8, '9':9, 'T':10, 'J':10, 'Q':10, 'K':10}

# define card class
class Card(LatinSuitedCard):
    SIZE = (73, 98)
    CENTER = (36.5, 49)
    BACK_SIZE = (71, 96)
    BACK_CENTER = (35.5, 48)

    def __init__(self, card, image):
        self.image = image
        if card is None:
            self.bad_card(card)
        elif (card[0] in self.SUITS) and (card[1] in self.RANKS):
            self.suit = card[0]
            self.rank = card[1]
        else:
            self.bad_card(card)

    def bad_card(self, card):
        self.suit = None
        self.rank = None
        if not card is None:
            print "Invalid card: ", card

    def __str__(self):
        return self.suit + self.rank

    def draw(self, canvas, loc):
        if self.suit is None or self.rank is None:
            return
        elif self.suit and self.rank:
            rotation = 0
            if len(loc) == 3:
                rotation = loc[2]
            i = self.RANKS.index(self.rank)
            j = self.SUITS.index(self.suit)
            center = self.CENTER
            size = self.SIZE
            if self.image != card_imgs:
                center = self.BACK_CENTER
                size = self.BACK_SIZE

            card_pos = [center[0] + i * size[0] ,
                        center[1] + j * size[1] ]
            canvas.draw_image(self.image, card_pos,
                              (71, 96), (loc[0],loc[1]), size, rotation)

# define hand class
class Hand(LatinSuitedCard):
    cards = []
    isDealer = False
    doDispose = False
    hideDealerCard = True

    def clear(self):
        self.cards = []
        self.doDispose = False

    def dispose(self):
        self.doDispose = True

    def __init__(self, isDealer):
        self.clear()
        self.isDealer = isDealer

    def show_dealer_card(self, value = False):
        self.hideDealerCard = value

    def add_card(self, card):
        self.cards.append([card, DEAL_POS[:]])

    def get_value(self):
        has_ace = False
        value = 0
        for card in self.cards:
            rank = card[0][1]
            if rank in self.VALUES:
                if rank == 'A':
                    has_ace = True
                value += self.VALUES[rank]

        if has_ace and value < 12:
            value += 10
        return value

    def draw(self, canvas):
        x = 400
        y = 470
        rotation = 9.425
        if self.doDispose:
            x, y, rotation = LAED_POS[:]
        elif self.isDealer:
            y = 170
        allcentered = True        
        for j in range(len(self.cards)):
            rot = rotation
            image = card_imgs
            pos = self.cards[j][1]
            dCard = self.cards[j][0]
            xinc = j * 25            
            if self.isDealer and j == 0:
                xinc = -20
                if self.hideDealerCard:
                    image = card_back
                    dCard = ('C','A')
                else: 
                    rot = self.cards[0][1][2]
                    if rot > 9: rot -= 0.01
            card = Card(dCard, image)
            card.draw(canvas, pos)
            self.cards[j][1] = GetNewPos(pos, [x + xinc, y + j*5, rot])
            if rotation != self.cards[j][1][2]: allcentered = False
        if self.doDispose and allcentered:
            self.clear()
            isRunningAnimation = True
            gameTimer.start()

# define deck class
class Deck(LatinSuitedCard):
    def __init__(self):
        self.cards = []
        self.add_cards()
        self.spell = self.spelled()
        
    def add_cards(self):
        for s in self.SUITS:
            for r in self.RANKS:
                self.cards.append((s,r))

    def new_deck(self):
        self.cards = []
        self.add_cards()
        self.shuffle()
        
    def shuffle(self):
        random.shuffle(self.cards)

    def has_cards(self):
        return len(self.cards) > 0

    def spelled(self):
         return  [
         [40,60,0], [40,152,0.1], [40,240,0], [110,50,8], [110,145,7.85], [110,250,7.8], [140,75,9], [140,170,8.7],
         [240,60,0], [241,153,0], [243,240,0], [300,250,7.85],
         [420,60,0.1], [410,156,0.15], [400,238,0.08], [470,60,9.2], [490,148,9.25], [510,228,9.2], [450,200,7.85],
         [600,70,0.4], [580,153,0], [600,230,8.9], [630,50,7.9], [630,240,7.7],
         [730,60,0], [730,153,0.1], [730,240,0], [810,160,8.7], [840,230,6], [840,80,0.5],
         SEPARATR,
         [180,360,0], [181,443,0], [173,520,0.2], [210,345,7.85], [130,345,7.85], [130,550,7.8], [70,530,6],
         [320,360,0.1], [310,456,0.15], [300,538,0.08], [370,360,9.2], [390,448,9.25], [410,528,9.2], [350,500,7.85],
         [500,370,0.4], [480,453,0], [500,530,8.9], [530,350,7.9], [530,540,7.7],
         [630,360,0], [630,453,0.1], [630,540,0], [740,530,6], [740,380,0.5], [710,460,8.7]
         ]

    def deal_card(self):
        if self.has_cards():
            return self.cards.pop()
        else:
            self.add_cards()
            self.shuffle()
            print "Deck is out of cards"

#define event handlers for buttons
def deal():
    global isRunningAnimation, doReduce, message, DealerPoints   
    if not doReduce:
        doReduce = True
    elif isRunningAnimation:
        return
    else:
        isRunningAnimation = True
        dealerHand.show_dealer_card(True)
        playerHand.dispose()
        dealerHand.dispose()
        if message == "":
            message = "You lose"
            DealerPoints += 1
        else:
            message = ""

def hit():
    global doReduce, isRunningAnimation, message    
    if not doReduce:
        doReduce = True
    elif isRunningAnimation:
        return
    elif playerHand.get_value() > 21:
        stand()
    elif message == "":
        card = BlackJackDeck.deal_card()
        if not card is None:
            playerHand.add_card(card)
            if playerHand.get_value() > 21:
                stand() 

def stand():
    global isRunningAnimation, doReduce, message
    global PlayerPoints, DealerPoints, bust
    if not doReduce:
        doReduce = True
    elif isRunningAnimation:
        return
    elif len(dealerHand.cards) < 13:
        dealerHand.show_dealer_card()
        p = playerHand.get_value()
        d = dealerHand.get_value()
        if p < 22 and p > d:
            while (d < 17):
                card = BlackJackDeck.deal_card()
                if card is None:
                    break
                else:
                    dealerHand.add_card(card)
                d = dealerHand.get_value()
        print p, d
        if message == "":
            if p > 21: 
                bust = True
                message = "You lose"
                DealerPoints += 1
            elif d > 21:
                bust = True
                message = "You win"
                PlayerPoints += 1
            elif p > d: 
                message = "You win"
                PlayerPoints += 1
            else: 
                message = "You lose"
                DealerPoints += 1
        print message

def mouse_handler(pos):
    global doReduce
    if not doReduce:
        doReduce = True

def GetNewPos(pos, finalpos):
    if doReduce:
        x = finalpos[0]
        if pos[0] > x:
            pos[0] -= 1 + (pos[0] - x)//10
        elif pos[0] < x:
            pos[0] += 1 + (x - pos[0])//10
        y = finalpos[1]
        if pos[1] > y:
            pos[1] -= 1 + (pos[1] - y)//10
        elif pos[1] < y:
            pos[1] += 1 + (y - pos[1])//10
        if pos[1] == y and pos[0] == x:
            rotation = finalpos[2]
            if pos[2] > rotation:
                pos[2] = rotation
            elif pos[2] < rotation:
                pos[2] += 0.1 + ((rotation - pos[2])//2)
    return [pos[0],pos[1],pos[2]]

def draw_table(canvas):
    canvas.draw_circle((450, -580), 1200, 20, "#800000", "Green")
    canvas.draw_circle((450, -600), 1000, 5, "#003300", "#0B6121")
    notice = "Dealer must draw to 16 and always stand on all 17s"
    canvas.draw_text(notice, (250, 360), 20, "Black")
    canvas.draw_text("BlackJack", (251, 101), 100, "Black")
    canvas.draw_text("BlackJack", (250, 100), 100, "#003300")
    canvas.draw_text("Player", (381, 581), 30, "Black")
    canvas.draw_text("Player", (380, 580), 30, "#0B6121")

def draw_score(canvas):
    canvas.draw_circle((700, 100), 8, 2, "Black", "White")
    canvas.draw_circle((700, 200), 8, 2, "Black", "White")
    canvas.draw_circle((850, 100), 8, 2, "Black", "White")
    canvas.draw_circle((850, 200), 8, 2, "Black", "White")
    canvas.draw_line((700, 150), (850, 150), 119, "Black")
    canvas.draw_line((700, 150), (850, 150), 115, "White")
    notice = "Score Board"
    canvas.draw_text(notice, (702, 113), 22, "Black", "monospace")
    canvas.draw_text(notice, (703, 114), 22, "Black", "monospace")
    canvas.draw_line((703, 117), (847, 117), 2, "Black")
    canvas.draw_text("Player", (705, 140), 18, "Black", "monospace")
    canvas.draw_text("Dealer", (780, 140), 18, "Black", "monospace")
    canvas.draw_line((775, 120), (775, 200), 2, "Black")
    canvas.draw_text(str(PlayerPoints), (725, 170), 24, "Black")
    canvas.draw_text(str(DealerPoints), (800, 170), 24, "Black")


def draw_question(canvas):
    global shake
    if isRunningAnimation:
        shake = 40
    else:
        question = "  New deal?"
        if message == "":
            question = "Hit or stand?"
        if shake > 0: shake -= 1
        y = 60 + math.sin(shake)*2
        x = 40 + math.cos(shake)*2
        canvas.draw_circle((4, 4), 3, 1, "Black", "White")
        canvas.draw_circle((8, 16), 4, 1, "Black", "White")
        canvas.draw_circle((16, 30), 8, 1, "Black", "White")
        canvas.draw_circle((x, y), 26, 1, "Black", "White")
        canvas.draw_circle((x+180, y), 26, 1, "Black", "White")
        if shake == 0:
            canvas.draw_line((x, y), (x+180, y), 52, "Black")
        canvas.draw_line((x, y), (x+180, y), 50, "White")
        canvas.draw_text(question, (x-9, y+12), 38, "Black")
        canvas.draw_text(question, (x-10, y+12), 38, "Red")
    
def draw_message(canvas):
    canvas.draw_circle((250, 330), 46, 1, "Black", "Cyan")
    canvas.draw_circle((630, 330), 46, 1, "Black", "Cyan")
    canvas.draw_line((250, 330), (630, 330), 92, "Black")
    canvas.draw_line((250, 330), (630, 330), 90, "Cyan")
    canvas.draw_text(message, (256, 361), 100, "White")
    canvas.draw_text(message, (255, 360), 100, "#00008B")
    if bust:
        bustmsg = "Bust"
        fontsize = 30
        x = 585        
        if message == "You win":
            bustmsg = "Dealer bust"
            fontsize = 28
            x = 360
        canvas.draw_text(bustmsg, (x+1, 311), fontsize, "White")
        canvas.draw_text(bustmsg, (x, 310), fontsize, "Black")

def draw_word(canvas):
    i = 0
    grouped = True
    endPos = INIT_POS
    for j in range(len(BlackJackDeck.spell)):
        pos = BlackJackDeck.spell[j]
        if pos != SEPARATR:
            card = Card(BlackJackDeck.cards[i], card_imgs)
            card.draw(canvas, pos)
            if pos[2] != endPos[2]: grouped = False
            BlackJackDeck.spell[j] = GetNewPos(pos, endPos)
        else:
            i = 26
        i += 1
        if i == 26: i = 8
    return grouped

def draw_snake(canvas):
    endShuffle = True
    endPos = INIT_POS
    for j in range(len(BlackJackDeck.spell)):
        pos = BlackJackDeck.spell[j]
        card = Card(('C','A'), card_back)
        card.draw(canvas, pos)
        xinc = j * 14.0
        yinc = int(math.sin((j * 2.0 + 800)/10) * 80.0)  + 90
        BlackJackDeck.spell[j] = GetNewPos(pos, [endPos[0] - xinc, endPos[1] + yinc, endPos[2]+0.4])
        BlackJackDeck.shuffle()
        if pos[2] != endPos[2] + 0.4: endShuffle = False
    return endShuffle

def draw_closing(canvas):
    allcentered = True
    for j in range(len(BlackJackDeck.spell)):
        pos = BlackJackDeck.spell[j]
        card = Card(('C','A'), card_back)
        card.draw(canvas, pos)
        BlackJackDeck.spell[j] = GetNewPos(pos, DEAL_POS[:])
        BlackJackDeck.shuffle()
        if pos[2] != 9: allcentered = False
    return allcentered

# draw handler
def draw(canvas):
    global start, showName, shuffling
    draw_table(canvas)

    endPos = INIT_POS
    allcentered = True
    endShuffle = True
    grouped = True
    if start:
        draw_score(canvas)
        playerHand.draw(canvas)
        dealerHand.draw(canvas)
    else:
        if showName:
            endShuffle = False
            grouped = draw_word(canvas)
        elif shuffling:
            allcentered = False
            endShuffle = draw_snake(canvas)
        else:
            allcentered = draw_closing(canvas)
            if allcentered: gameTimer.start()

    if grouped:
        showName = False
        if endShuffle:
            shuffling = False
            if allcentered:
                start = True

    canvas.draw_line((0, 50), (0, 250), 20, "Black")
    canvas.draw_line((WIDTH, 50), (WIDTH, 250), 20, "Black")
    draw_question(canvas)
    if message != "":
        draw_message(canvas)        

def game_timer_handler():
    global isRunningAnimation, message, bust
    pCards = len(playerHand.cards)
    dCards = len(dealerHand.cards)
    if (dCards + pCards) == 0:
        if len(BlackJackDeck.cards) < 13:
            BlackJackDeck.new_deck()
    if BlackJackDeck.has_cards():
        if pCards < 2 and pCards < dCards:
            card = BlackJackDeck.deal_card()
            playerHand.add_card(card)
        elif dCards < 2:
            card = BlackJackDeck.deal_card()
            dealerHand.add_card(card)
    if (dCards + pCards) > 1:
        message = ""
        bust = False
        if (dCards + pCards) > 3:
            gameTimer.stop()
            isRunningAnimation = False

def autoplay():
    global btnAutoPlay
    if autoPlayTimer.is_running():
        autoPlayTimer.stop()
        btnAutoPlay.set_text("AutoPlay")
    else:
        autoPlayTimer.start()
        btnAutoPlay.set_text("Stop AutoPlay")

def timer_handler():    
    if message == "":
        if playerHand.get_value() < 18:
            hit()
        else:
            stand()
    else:
        deal()
        
# initialization frame

frame = simplegui.create_frame("Blackjack", WIDTH, HIGHT, 100)
frame.set_canvas_background("Black")

#create buttons and canvas callback
frame.set_mouseclick_handler(mouse_handler)
frame.add_button("Deal", deal, 100)
frame.add_button("Hit",  hit, 100)
frame.add_button("Stand", stand, 100)
frame.set_draw_handler(draw)
frame.add_label("")
frame.add_label("")
frame.add_label("")
btnAutoPlay = frame.add_button("AutoPlay", autoplay, 100)
autoPlayTimer = simplegui.create_timer(1000, timer_handler)

gameTimer = simplegui.create_timer(400, game_timer_handler)

BlackJackDeck = Deck()
dealerHand = Hand(True)
playerHand = Hand(False)

# get things rolling
frame.start()

