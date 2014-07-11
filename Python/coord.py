import os
import math

MAP_MAX_ZOOM_LEVEL = 17

def coord_to_path(tile_coord):
    return os.path.join(
                        str(tile_coord[2]),
                        str(tile_coord[0] / 1024),
                        str(tile_coord[0] % 1024),
                        str(tile_coord[1] / 1024),
                        str(tile_coord[1] % 1024) + ".png"
                       )

def tiles_on_level(zoom_level):
    return 1 << (MAP_MAX_ZOOM_LEVEL - int(zoom_level))

def coord_to_tile(coord):
    world_tiles = tiles_on_level(coord[2])
    x = world_tiles / 360.0 * (coord[1] + 180.0)
    tiles_pre_radian = world_tiles / (2 * math.pi)
    e = math.sin(coord[0] * (1 / 180. * math.pi))
    y = world_tiles / 2 + 0.5 * math.log((1 + e) / (1 - e)) * (-tiles_pre_radian)
    offset = int((x - int(x)) * 256), \
             int((y - int(y)) * 256)
    return (int(x) % world_tiles, int(y) % world_tiles), offset



coord = [21.0688888889, 105.8125, -2]
map_coord = coord_to_tile(coord)
tile_coord = [map_coord[0][0], map_coord[0][1], coord[2]]
path = coord_to_path(tile_coord)



print ""
print "coord = " 
print coord

print ""
print "map_coord = " 
print map_coord

print ""
print "tile_coord = " 
print tile_coord

print ""
print "path = " 
print path
print ""
