# Spaceship
import simplegui
import math
import random

# globals for user interface
DEBUG = False
PAUSED = False
started = False
ASTER_COLL = False
frame_closed = False
MAX_ASTEROIDS = 12
WIDTH = 800
HEIGHT = 600
LEFT_KEYS = [65, 37]
RIGHT_KEYS = [68, 39]
THRUST_KEYS = [87, 38]
score = 0
lives = 3
time = 0


ASSETS_URL = "http://commondatastorage.googleapis.com/codeskulptor-assets/"

class ImageInfo:    
    def __init__(self, img, center, size, radius = 0, lifespan = 0, animated = False, dimensions = []):
        self.center = center
        self.size = size
        self.radius = radius
        self.dimensions = dimensions
        self.lifespan = lifespan
        self.animated = animated
        COMMON_URL = ASSETS_URL
        if lifespan != 60: COMMON_URL += "lathrop/"
        self.image = simplegui.load_image(COMMON_URL + img)

    def get_center(self):
        return self.center

    def get_size(self):
        return self.size

    def get_radius(self):
        return self.radius

    def get_lifespan(self):
        return self.lifespan

    def get_animated(self):
        return self.animated

    
# splash image
splash_info = ImageInfo("splash.png", [200, 150], [400, 300])

# art assets created by Kim Lathrop, may be freely re-used in non-commercial projects
debris_info = ImageInfo("debris2_blue.png", [320, 240], [640, 480])
nebula_info = ImageInfo("nebula_blue.png", [400, 300], [800, 600])
splash_info = ImageInfo("splash.png", [200, 150], [400, 300])
ship_info = ImageInfo("double_ship.png", [45, 45], [90, 90], 35)
missile_info = ImageInfo("shot1.png", [5,5], [10, 10], 3, 45)

asteroids_info = [ImageInfo("asteroid_blend.png", [45, 45], [90, 90], 40)]
asteroids_info.append(ImageInfo("asteroid_brown.png", [45, 45], [90, 90], 40))
asteroids_info.append(ImageInfo("asteroid_blue.png", [45, 45], [90, 90], 40))

explosions_info = [ImageInfo("explosion_alpha.png", [64, 64], [128, 128], 17, 24, True, [24, 1])]
explosions_info.append(ImageInfo("explosion.hasgraphics.png", [50, 50], [100, 100], 40, 60, True, [9, 9]))


# sound assets purchased from sounddogs.com, please do not redistribute
soundtrack = simplegui.load_sound(ASSETS_URL + "sounddogs/soundtrack.mp3")
missile_sound = simplegui.load_sound(ASSETS_URL + "sounddogs/missile.mp3")
missile_sound.set_volume(.5)
ship_thrust_sound = simplegui.load_sound(ASSETS_URL + "sounddogs/thrust.mp3")
explosion_sound = simplegui.load_sound(ASSETS_URL + "sounddogs/explosion.mp3")

# helper functions to handle transformations
def angle_to_vector(ang):
    return [math.cos(ang), math.sin(ang)]

def points_to_angle(p, q):
    return normalize_angle(math.atan2(p[1] - q[1], p[0] - q[0]))

def normalize_angle(ang):
    if not (0 < ang < math.pi * 2):
            ang = math.fabs((math.pi * 2) - math.fabs(ang))
    return ang

def angle_diff(pAng, qAng):
    steer_right = pAng > qAng
    ang_diff = math.fabs(pAng - qAng)
    if ang_diff > math.pi:
        steer_right = not steer_right
        if pAng < qAng:
            ang_diff = pAng + (2*math.pi - qAng)            
        else:            
            ang_diff = qAng + (2*math.pi - pAng)            
    return ang_diff, steer_right

def dist(p, q):
    return math.sqrt((p[0] - q[0]) ** 2+(p[1] - q[1]) ** 2)

def str_pos(p, val = 0):
    if val <= 0:
        return str([int(p[0]), int(p[1])])
    else:
        return str(p[0])[:val] + ', ' + str(p[1])[:val]

class Sprite:
    thrusting = False
    accel = 0
    dccel = 0
    age = 0
        
    def __init__(self, info, pos, vel, friction, ang, ang_vel = 0, sound = None):
        self.pos = [pos[0],pos[1]]
        self.vel = [vel[0],vel[1]]
        self.angle = ang
        self.angle_vel = ang_vel
        self.image = info.image
        self.friction = friction
        self.image_center = info.get_center()
        self.image_size = info.get_size()
        self.radius = info.get_radius()        
        self.lifespan = info.get_lifespan()
        self.animated = info.get_animated()
        self.dimensions = info.dimensions
        self.sound = sound
        self.play_sound()

    def play_sound(self):
        if self.sound:
            self.sound.rewind()
            self.sound.play()

    def draw_image(self, canvas, debug):
        center = self.image_center
        if debug:
            p = self.pos
            canvas.draw_circle(p, self.radius, 3, "Cyan")
            canvas.draw_text(str(self.angle_vel)[:6], [p[0]-15,p[1]-10], 12, "lime")
            canvas.draw_text(str_pos(p), [p[0]-25,p[1]+5], 12, "Red")
            canvas.draw_text(str_pos(self.vel,5), [p[0]-25,p[1]+20], 12, "white")
        else:
            if self.animated:
                index = [self.age % self.dimensions[0], (self.age // self.dimensions[0]) % self.dimensions[1]]            
                center = [center[0] + index[0] * self.image_size[0], center[1] + index[1] * self.image_size[1]]
            canvas.draw_image(self.image, center, self.image_size, self.pos, self.image_size, self.angle)

    def draw(self, canvas, paused, debug):
        if self.animated:
            if self.lifespan >= self.age:
                self.draw_image(canvas, debug)
            if not paused: self.age += 1
        else:
            self.draw_image(canvas, debug)            
        self.update(paused)

    def thrust_vector(self):
        vector = [1,1]
        if self.thrusting:
            vector = angle_to_vector(self.angle) 
        return vector

    def reverse_movement(self, v):
        self.angle_vel = self.angle_vel * 0.999
        if self.angle_vel < 0.000001: 
            self.angle_vel = 0
        self.vel = [v[0] * 0.99, v[1] * 0.99]

    def speed(self):
        return math.sqrt((self.vel[0] ** 2) + (self.vel[0] ** 2))

    def upd_vel(self, value, maxpos, t_vector):        
        self.dccel = self.vel[value] * self.friction * t_vector[value]
        self.vel[value] += (self.accel - self.dccel) * t_vector[value]
        if not self.thrusting:
            if (-0.1 < self.vel[value] < 0.1): 
                self.vel[value] = 0
        self.pos[value] += self.vel[value]
        gain = self.radius / 2 
        if self.pos[value] > maxpos + gain:
            self.pos[value] = -gain
        elif self.pos[value] < -gain:
            self.pos[value] = maxpos + gain

    def update(self, paused):
        if not paused:
            self.angle += self.angle_vel
            self.angle = normalize_angle(self.angle)
            t_vector = self.thrust_vector()        
            self.upd_vel(0, WIDTH , t_vector)
            self.upd_vel(1, HEIGHT, t_vector)
    
    def collision(self, pos, radius):
        return dist(self.pos, pos) < (self.radius + radius)

class Ship(Sprite):
    route = []
    missiles = []
    fire_freq = 0
    max_missiles = 5
    left_angle_vel = 0
    right_angle_vel = 0
    autopilot = False
    autofire = False
    braking = False
    play_thrust = True

    ## Accelerate the ship by given value
    def thrust(self, accelVal):
        self.accel = accelVal
        self.thrusting = accelVal > 0
        if self.thrusting:
            if started:
                ship_thrust_sound.play()
        else:
            ship_thrust_sound.rewind()
        self.image_center[0] = 45 + self.image_size[0] * int(self.thrusting)

    ## Turn on the autofire and set a frequency
    def auto_shoot(self, freq):
        self.autofire = True
        self.fire_freq = freq

    ## Fire randomly to the set frequency
    def random_shoot(self):
        if self.fire_freq < 2:
            return
        if random.randint(0, self.fire_freq) == 0:
            self.shoot()

    ## Reset autopilot
    def auto_reset(self):
        self.autopilot = False
        self.thrust(0)
        self.route = []
        self.right_angle_vel = 0
        self.left_angle_vel = 0

    ## Add a new destination and switch ON autopilot
    def auto_drive(self, toPos):
        self.autopilot = True
        self.route.append(toPos)
        self.drive_to(toPos)

    ## Use the brakes to stop
    # rotate the ship against the current direction
    # and fire the thursters to counter acceleration
    def brake(self):
        DECEL = 2
        if self.accel >= DECEL or self.vel == [0,0]:
            self.thrust(0)
            self.braking = False
            self.right_angle_vel = 0
        else:
            self.right_angle_vel = 0
            dAngle = points_to_angle([0,0], self.vel)
            ang_diff, s = angle_diff(dAngle, self.angle)
            if ang_diff > 0.1:
                self.right_angle_vel = 0.05
            else:
                self.thrust(DECEL + self.speed()/2)

    ## Move the ship to the given position
    def drive_to(self, toPos):
        self.right_angle_vel = 0
        self.left_angle_vel = 0
        if self.autopilot:
            vPos = [toPos[0] - self.vel[0]*50, toPos[1] - self.vel[1]*50]
            pAng = points_to_angle(vPos , self.pos)
            ang_diff, steer_right = angle_diff(pAng, self.angle)
            if ang_diff < 0.02:                
                self.thrust(0.08)
            elif ang_diff > 1:
                self.thrust(0)
            if steer_right:
                self.right_angle_vel = 0.01 + ang_diff/15
            else:
                self.left_angle_vel = 0.01 + ang_diff/15
            if (dist(toPos, self.pos) < self.radius + 10):
                if len(self.route) == 1:
                    self.autopilot = False
                    self.autoshoot = False
                    self.braking = True
                self.route.pop(0)
        if not self.autopilot:            
            self.thrust(0)
            self.right_angle_vel = 0
            self.left_angle_vel = 0

    ## Fire one missile
    def shoot(self):
        vector = angle_to_vector(self.angle)        
        pos = [self.pos[0] + vector[0] * self.radius,
               self.pos[1] + vector[1] * self.radius]        
        vel = [vector[0] * 10 + self.vel[0] ,
               vector[1] * 10 + self.vel[1]]
        if len(self.missiles) >= self.max_missiles: 
            self.missiles.pop(0)
        self.missiles.append(Sprite(missile_info, pos, vel, 0, 0, 0, missile_sound))
    
    ## Draw current route
    def draw_route(self, canvas):
        for I in self.route:
            if I == self.route[0]:
                canvas.draw_circle(I, 20, 18, "Lime")
            else:
                canvas.draw_circle(I, 20, 12, "Green")
            canvas.draw_text(str(I), I, 12, "Red")
    
    ## Draw some debug lines
    def draw_debug(self, canvas, debug=False):
        if debug:
            canvas.draw_circle(self.pos, self.radius, 0.5, "White")
            if len(self.route) > 0:
                p = self.route[0]
                canvas.draw_line(self.pos, p, 3, "Blue")
                vPos = [p[0] - self.vel[0]*50, p[1] - self.vel[1]*50]
                canvas.draw_line(self.pos, vPos, 1, "Red")
                vPos = [p[0] + self.vel[0]*50,p[1] + self.vel[1]*50]
                canvas.draw_line(self.pos, vPos, 1, "Yellow") 
                self.draw_route(canvas)
    
    ## All the ship & missiles drawing 
    def draw(self, canvas, paused, debug):
        self.draw_debug(canvas, debug)
        if self.braking: 
            self.brake()
        elif self.autopilot:                        
            self.drive_to(self.route[0])
            if self.autofire:
                self.random_shoot()                
        self.angle_vel = self.right_angle_vel - self.left_angle_vel
        for missile in list(self.missiles):
            missile.draw(canvas, paused, False)
            if missile.age < missile.lifespan:
                if not paused: missile.age += 1
            else:
                self.missiles.remove(missile)
        canvas.draw_image(self.image, self.image_center, self.image_size, 
                              self.pos, self.image_size, self.angle)
        self.update(paused)
    
    ## checkes if there is a missile collision
    def misile_collision(self, pos, radius):
        collide = False
        for missile in list(self.missiles):
            if missile.collision(pos, radius):
                self.missiles.remove(missile)
                collide = True
                break
        return collide

def draw_debug(canvas):
    I = WIDTH / 8
    while I < WIDTH:
        canvas.draw_line([I,0], [I,HEIGHT], 0.25, "CYAN")
        I += WIDTH / 8 
    I = HEIGHT / 8
    while I < WIDTH:
        canvas.draw_line([0,I], [WIDTH,I], 0.25, "CYAN")
        I += HEIGHT / 8
    
def draw_background(canvas):
    global time
    # animate background
    time += 1
    if time > 10000000: time = 0
    center = debris_info.get_center()
    size = debris_info.get_size()
    wtime = (time / 10.0) % center[0]
    print wtime
    #canvas.draw_image(nebula_info.image, nebula_info.get_center(), nebula_info.get_size(), [WIDTH / 2, HEIGHT / 2], [WIDTH, HEIGHT])
    canvas.draw_image(debris_info.image, [center[0] - wtime, center[1]], [size[0] - 2 * wtime, size[1]], 
                                [WIDTH / 2 + 1.25 * wtime, HEIGHT / 2], [WIDTH - 2.5 * wtime, HEIGHT])
    if wtime > 0:
        canvas.draw_image(debris_info.image, [size[0] - wtime, center[1]], [2 * wtime, size[1]], 
                                [1.25 * wtime, HEIGHT / 2], [2.5 * wtime, HEIGHT])

def draw_text(canvas, message, x, y, size):
    canvas.draw_text(message, [x-1,y-1], size, "White") 
    canvas.draw_text(message, [x+1,y+1], size, "White")
    canvas.draw_text(message, [x+1,y-1], size, "White")
    canvas.draw_text(message, [x-1,y+1], size, "White")
    canvas.draw_text(message, [x,y], size, "Blue") 

def draw_explosions(canvas):
    for explosion in list(explosions):
        if explosion.age > explosion.lifespan:
            explosions.remove(explosion)
        else:
            explosion.draw(canvas, PAUSED, False)

def explode(exp, pos):
    global explosions
    explosions.append(Sprite(explosions_info[exp], pos, [0, 0], 0, 0, 0, explosion_sound))

def check_aster_coll():    
    for I in range(len(a_rocks)-1):
        for J in range(I+1, len(a_rocks)):
            if a_rocks[I].collision(a_rocks[J].pos, a_rocks[J].radius):
                Jv = a_rocks[J].vel
                Iv = a_rocks[I].vel
                a_rocks[I].reverse_movement([Jv[0],Jv[1]])
                a_rocks[J].reverse_movement([Iv[0],Iv[1]])
    
def check_collisions():
    global a_rocks, score, lives, started
    if ASTER_COLL: check_aster_coll()
    for asteroid in list(a_rocks):                       
        if my_ship.collision(asteroid.pos, asteroid.radius):
            explode(1, asteroid.pos)
            a_rocks.remove(asteroid)
            lives -= 1
            if lives == 0:
                started = False
                my_ship.auto_drive([WIDTH / 2, HEIGHT *2/3])
        else:
            if my_ship.misile_collision(asteroid.pos, asteroid.radius):
                explode(0, asteroid.pos)
                a_rocks.remove(asteroid)
                score += 1        

def draw(canvas):
    global a_rocks, frame_closed
    check_collisions()
    if DEBUG:
        draw_debug(canvas)
    else:
        draw_background(canvas)    
    # draw ship and sprites    
    for asteroid in a_rocks:
        asteroid.draw(canvas, PAUSED, DEBUG) 
    my_ship.draw(canvas, PAUSED, DEBUG)
    if not DEBUG:
        draw_text(canvas, "Lives: " + str(lives), 50, 30, 30)
        draw_text(canvas, "Score: " + str(score), WIDTH -150, 30, 30)
    draw_explosions(canvas)
    if not started:
        a_rocks = []
        my_ship.right_angle_vel = 0.01
        canvas.draw_image(splash_info.image, splash_info.get_center(), 
                          splash_info.get_size(), [WIDTH / 2, HEIGHT / 2], 
                          splash_info.get_size())
    frame_closed = False

def key_event(key, keyVal):
    if not PAUSED:
        if my_ship.autopilot:
            my_ship.auto_reset()
        ACCEL = 0.1   
        if key in LEFT_KEYS: # Left
            my_ship.left_angle_vel = ACCEL * keyVal/2 
        elif key in RIGHT_KEYS: # Right
            my_ship.right_angle_vel = ACCEL * keyVal/2
        elif key in THRUST_KEYS: #Thrust       
            my_ship.thrust(ACCEL * keyVal)
        elif key == simplegui.KEY_MAP["space"]:
            if keyVal: my_ship.shoot()    
def keydown(key_handler):
    key_event(key_handler, 1)
def keyup(key_handler):
    key_event(key_handler, 0)
    if key_handler == 13:         
        print "- - - - - - - - - -"
        print "pos=", my_ship.pos
        print "vel=", my_ship.vel
        print "angle=", my_ship.angle
        print "angle2center=", points_to_angle([WIDTH / 2, HEIGHT / 2], my_ship.pos)

def mouse_handler(pos):
    global started, lives, score
    if not started:        
        center = [WIDTH / 2, HEIGHT / 2]
        size = splash_info.get_size()
        inwidth = (center[0] - size[0] / 2) < pos[0] < (center[0] + size[0] / 2)
        inheight = (center[1] - size[1] / 2) < pos[1] < (center[1] + size[1] / 2)
        if inwidth and inheight:
            my_ship.right_angle_vel = 0
            started = True
            lives, score = 3, 0
            soundtrack.rewind()
            soundtrack.play()
    elif DEBUG:
        my_ship.auto_drive(pos)
    

def random_pos():
    return [random.randint(0, WIDTH), random.randint(0, HEIGHT)]

def exit_all():
    soundtrack.pause()
    missile_sound.pause()
    ship_thrust_sound.pause()
    explosion_sound.pause()
    rock_timer.stop()

# timer handler that spawns a rock    
def rock_spawner():
    global a_rocks, asteroid_info, frame_closed
    if frame_closed:
        exit_all()
    elif not started:
        my_ship.auto_drive([WIDTH / 2, HEIGHT *2/3])
    elif len(a_rocks) < MAX_ASTEROIDS:
        r = random.randint(-10, 10)/100.0
        vx = random.randint(-15, 15)/10.0
        vy = random.randint(-15, 15)/10.0        
        random.shuffle(asteroids_info)  
        radius = asteroids_info[0].radius
        #Avoid spawning a new item on top of others
        collision = True
        while collision:
            collision = False
            pos = random_pos()
            for asteroid in a_rocks:
                collision = asteroid.collision(pos, radius+10)
                if collision: break
            if not collision:
                collision = my_ship.collision(pos, radius*2)
        a_rocks.append(Sprite(asteroids_info[0], pos, [vx, vy], 0, 0, r))
    frame_closed = True

def btn_random_drive():
    my_ship.auto_shoot(50)
    my_ship.route = []    
    for i in range(8):
        x =	random.randint(0, WIDTH)
        y =	random.randint(0, HEIGHT)
        my_ship.auto_drive([x, y])

def btn_center_drive():    
    my_ship.auto_shoot(0)
    my_ship.route = []    
    center = [WIDTH / 2, HEIGHT / 2]
    my_ship.auto_drive(center)
    
def btn_victory_laps_drive():
    my_ship.auto_shoot(10)
    my_ship.route = []
    for i in range(3): 
        my_ship.auto_drive([WIDTH * 3/8, HEIGHT * 3/8])
        my_ship.auto_drive([WIDTH * 5/8, HEIGHT * 3/8])
        my_ship.auto_drive([WIDTH * 5/8, HEIGHT * 5/8])
        my_ship.auto_drive([WIDTH * 3/8, HEIGHT * 5/8])

def btn_debug_mode():
    global DEBUG, lives
    DEBUG = not DEBUG
    lives = 999 if DEBUG else 3
    btnDebug.set_text("Normal Mode" if DEBUG else "Debug Mode")
    label.set_text("Click on canvas" if DEBUG else "")

def btn_aster_coll():
    global ASTER_COLL
    ASTER_COLL = not ASTER_COLL
    btnAsterColl.set_text("Normal Coll" if ASTER_COLL else "Aster Coll")

def btn_restart():
    global DEBUG, ASTER_COLL, MAX_ASTEROIDS, PAUSED
    global score, lives, time, explosions
    global a_rocks, my_ship, rock_timer, started
    started = False
    rock_timer.stop()
    my_ship.auto_reset()
    my_ship = None    
    DEBUG = False
    btnDebug.set_text("Debug Mode")
    PAUSED = False
    btnPause.set_text("PAUSE")
    ASTER_COLL = False
    btnAsterColl.set_text("Aster Coll")
    MAX_ASTEROIDS = 12
    score = 0
    lives = 3
    time = 0
    explosions = []
    a_rocks = []
    my_ship = Ship(ship_info, [WIDTH / 2, HEIGHT *2/3], [0, 0], 0.01, 0)
    rock_timer.start()

def btn_pause():
    global PAUSED
    PAUSED = not PAUSED
    btnPause.set_text("RESUME" if PAUSED else "PAUSE")
    if PAUSED:
        rock_timer.stop()
    else:
        rock_timer.start()
    

# initialize frame
frame = simplegui.create_frame("Asteroids", WIDTH, HEIGHT, 100)

# initialize ship and two sprites
my_ship = Ship(ship_info, [WIDTH / 2, HEIGHT *2/3], [0, 0], 0.01, 0)
explosions = []
a_rocks = []


# register handlers
frame.set_draw_handler(draw)
frame.set_mouseclick_handler(mouse_handler)
frame.set_keydown_handler(keydown)
frame.set_keyup_handler(keyup)

soundtrack.play()
rock_timer = simplegui.create_timer(1000, rock_spawner)
frame.add_button("RESTART", btn_restart, 100)
btnPause = frame.add_button("PAUSE", btn_pause, 100)
frame.add_label("")
frame.add_label("")
frame.add_button("Random Drive", btn_random_drive, 100)
frame.add_label("")
frame.add_button("Center Flyby", btn_center_drive, 100)
frame.add_label("")
frame.add_button("Victory Laps", btn_victory_laps_drive, 100)
frame.add_label("")
frame.add_label("")
label = frame.add_label("")
btnDebug = frame.add_button("Debug Mode", btn_debug_mode, 100)
frame.add_label("")
btnAsterColl = frame.add_button("Aster Coll", btn_aster_coll, 100)

# get things rolling
rock_timer.start()
frame.start()
