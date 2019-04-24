import numpy as np
import cv2

def mergeoverlaylabel(label_result):
    final_result =[]
    
    pre_temp = {'label': label_result[0]['label'], 'confidence': -1, 'topleft': \
                {'x': label_result[0]['topleft']['x'], 'y': label_result[0]['topleft']['y']},\
                'bottomright': {'x': label_result[0]['bottomright']['x'], 'y': label_result[0]['bottomright']['y']}}

    merge_tf = False
    for a_result in label_result:
        merge_tf = False
        topleft = [a_result['topleft']['x'],a_result['topleft']['y']]
        topright = [a_result['bottomright']['x'],a_result['topleft']['y']]
        bottomleft = [a_result['topleft']['x'],a_result['bottomright']['y']]
        bottomright = [a_result['bottomright']['x'],a_result['bottomright']['y']]
        
        pre_topleft = [pre_temp['topleft']['x'],pre_temp['topleft']['y']]
        pre_topright = [pre_temp['bottomright']['x'],pre_temp['topleft']['y']]
        pre_bottomleft = [pre_temp['topleft']['x'],pre_temp['bottomright']['y']]
        pre_bottomright = [pre_temp['bottomright']['x'],pre_temp['bottomright']['y']]
        
		

        # pre include current
        if topleft[0] > pre_temp['topleft']['x'] and topleft[0] <= pre_temp['bottomright']['x']:
            if topleft[1] > pre_temp['topleft']['y'] and topleft[1] <= pre_temp['bottomright']['y']:
                merge_tf = True
                if  a_result['confidence'] > pre_temp['confidence']:
                    pre_temp = a_result
        
        if topright[0] > pre_temp['topleft']['x'] and topright[0] <= pre_temp['bottomright']['x']:
            if topright[1] > pre_temp['topleft']['y'] and topright[1] <= pre_temp['bottomright']['y']:
                merge_tf = True
                if  a_result['confidence'] > pre_temp['confidence']:
                    pre_temp = a_result
                    
        if bottomleft[0] > pre_temp['topleft']['x'] and bottomleft[0] <= pre_temp['bottomright']['x']:
            if bottomleft[1] > pre_temp['topleft']['y'] and bottomleft[1] <= pre_temp['bottomright']['y']:
                merge_tf = True
                if  a_result['confidence'] > pre_temp['confidence']:
                    pre_temp = a_result
                    
        if bottomright[0] > pre_temp['topleft']['x'] and bottomright[0] <= pre_temp['bottomright']['x']:
            if bottomright[1] > pre_temp['topleft']['y'] and bottomright[1] <= pre_temp['bottomright']['y']:
                merge_tf = True
                if  a_result['confidence'] > pre_temp['confidence']:
                    pre_temp = a_result
                
                
                
        # current include pre
        if pre_topleft[0] > a_result['topleft']['x'] and pre_topleft[0] <= a_result['bottomright']['x']:
            if pre_topleft[1] > a_result['topleft']['y'] and pre_topleft[1] <= a_result['bottomright']['y']:
                merge_tf = True
                if  a_result['confidence'] > pre_temp['confidence']:
                    pre_temp = a_result

        if pre_topright[0] > a_result['topleft']['x'] and pre_topright[0] <= a_result['bottomright']['x']:
            if pre_topright[1] > a_result['topleft']['y'] and pre_topright[1] <= a_result['bottomright']['y']:
                if  a_result['confidence'] > pre_temp['confidence']:
                    pre_temp = a_result
                    
        if pre_bottomleft[0] > a_result['topleft']['x'] and pre_bottomleft[0] <= a_result['bottomright']['x']:
           if pre_bottomleft[1] > a_result['topleft']['y'] and pre_bottomleft[1] <= a_result['bottomright']['y']:
                merge_tf = True
                if  a_result['confidence'] > pre_temp['confidence']:
                    pre_temp = a_result
                    
        if pre_bottomright[0] > a_result['topleft']['x'] and pre_bottomright[0] <= a_result['bottomright']['x']:
            if pre_bottomright[1] > a_result['topleft']['y'] and pre_bottomright[1] <= a_result['bottomright']['y']:
                merge_tf = True
                if  a_result['confidence'] > pre_temp['confidence']:
                    pre_temp = a_result
        
        
        if not merge_tf:
            final_result.append(pre_temp)
            pre_temp = a_result
            merge_tf = False
            
    if merge_tf:
            final_result.append(pre_temp)

    return final_result

	
	
def boxing(original_img, predictions,confidence):
	newImage = np.copy(original_img)

	for result in predictions:
		top_x = result['topleft']['x']
		top_y = result['topleft']['y']

		btm_x = result['bottomright']['x']
		btm_y = result['bottomright']['y']

		conf = result['confidence']
		label = result['label'] + " " + str(round(confidence, 3))

		#         if conf > 0.3:
		#         if conf > 0.2:
		if conf > confidence:
		#         if conf > 0.4:
			newImage = cv2.rectangle(newImage, (top_x, top_y), (btm_x, btm_y), (255,0,0), 3)
			newImage = cv2.putText(newImage, label, (top_x, top_y-5), cv2.FONT_HERSHEY_COMPLEX_SMALL , 0.8, (0, 230, 0), 1, cv2.LINE_AA)

	return newImage