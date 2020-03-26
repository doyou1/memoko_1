package com.memoko.integrated.imageanalysis.service;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.ColorInfo;
import com.google.cloud.vision.v1.DominantColorsAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.LocalizedObjectAnnotation;
import com.google.cloud.vision.v1.NormalizedVertex;
import com.google.protobuf.ByteString;

public class GoogleVisionAPI {

	/**
	 * Detects localized objects in the specified local image.
	 *
	 * @param filePath The path to the file to perform localized object detection on.
	 * @param out A {@link PrintStream} to write detected objects to.
	 * @throws Exception on errors while closing the client.
	 * @throws IOException on Input/Output errors.
	 */
	public static ArrayList<HashMap<String,Object>> detectLocalizedObjects(String imagePath, int width, int height)
	    throws Exception, IOException {
		  System.out.println("detectLocalizedObjects func 시작");
		  
		  ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		  
		  List<AnnotateImageRequest> requests = new ArrayList<>();
	
		  ByteString imgBytes = ByteString.readFrom(new FileInputStream(imagePath));
	
		  Image img = Image.newBuilder().setContent(imgBytes).build();
		  AnnotateImageRequest request =
		      AnnotateImageRequest.newBuilder()
		          .addFeatures(Feature.newBuilder().setType(Type.OBJECT_LOCALIZATION))
		          .setImage(img)
		          .build();
		  requests.add(request);
		
		  // Perform the request
		  try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
		    BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
		    List<AnnotateImageResponse> responses = response.getResponsesList();
		
		    // Display the results
		    for (AnnotateImageResponse res : responses) {
		      for (LocalizedObjectAnnotation entity : res.getLocalizedObjectAnnotationsList()) {
		        int x = 1;
		        int y = 1;
		        HashMap<String,Object> map = new HashMap<>();
		        map.put("name", entity.getName());
		        map.put("score", entity.getScore());
		        map.put("width",width);
		        map.put("height",height);
		        
		        List<NormalizedVertex> vertexList = (List<NormalizedVertex>) entity.getBoundingPoly().getNormalizedVerticesList();
		            
		        for(NormalizedVertex vertex : vertexList) {
		        	map.put("x" + x, (int) Math.round(width * vertex.getX()));	
	            	map.put("y" + y, (int) Math.round(height * vertex.getY()));	
	            	x++;
	            	y++;
		        }
		        
		        list.add(map);
		      }
		      
		    }
		  }
		  
		  System.out.println("detectLocalizedObjects func 종료");
		  return list;
			 
	}


}
