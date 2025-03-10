import requests

key = "My_key" # new key for map, route and place

nearby__url = r"https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
distance_url ='https://maps.googleapis.com/maps/api/distancematrix/json?'
streetview_url = r"https://maps.googleapis.com/maps/api/streetview?"


def grabstreetview(location,fov=50,pitch=10,heading=0):	
	parameters = {"size" : "1280x1280", "location" : location , "key" : key, "fov":fov, "pitch": pitch, \
                 "source": "outdoor", "heading":heading}
    
	meta_request = requests.get(streetview_url, params=parameters)
	return meta_request

	
def searchnearby_radius(location,radius,type):
	
	parameters = {"location" : location, "radius" : radius , "key" : key, \
	"type":type}
	meta_request= requests.get(nearby__url, params=parameters)
	
	return meta_request
 
def searchnearby_rank(location,type):
	
	parameters = {"location" : location, "rankby": "distance" , "key" : key, \
	"type":type}
	meta_request= requests.get(nearby__url, params=parameters)
	
	return meta_request
  
def distancebetween(location,place_id):
	
    place_id = "place_id:"+place_id
    # rankby=distance
    parameters = {"origins" : location, "destinations" : place_id , "key" : key}
    meta_request= requests.get(distance_url, params=parameters)
    
    return meta_request