package com.memoko.integrated.imageanalysis.service;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.Storage.BucketGetOption;
import com.google.cloud.storage.StorageOptions;
import com.memoko.integrated.imageanalysis.vo.InputFoodVO;

public class MainForTest {
	
	public static void main(String[] args) throws IOException {
		String projectId = "my-project0228-269601";
		String computeRegion = "asia-east1";
		String productSetId = "MEMOKO-FOODS-99";
		String productSetDisplayName = "FOODS";
		String productCategory = "general-v1";
		

		GoogleProductSetManagement.createProductSet(
				"my-project0228-269601"
				, "asia-east1"
				, "MEMOKO-FOODS-98"
				, "FOODS");
		
		
		ArrayList<InputFoodVO> list = new ArrayList<>();
		
		list.add(new InputFoodVO("chicken","닭고기"));
		list.add(new InputFoodVO("pork","돼지고기"));
		list.add(new InputFoodVO("onion","양파"));
		list.add(new InputFoodVO("paprika","파프리카"));
		list.add(new InputFoodVO("radish","무"));
		list.add(new InputFoodVO("tomato","토마토"));
		list.add(new InputFoodVO("strawberry","딸기"));
		list.add(new InputFoodVO("mushroom","버섯"));
		list.add(new InputFoodVO("apple","사과"));
		list.add(new InputFoodVO("carrot","당근"));
		list.add(new InputFoodVO("potato","감자"));
		list.add(new InputFoodVO("sweetpotato","고구마"));
		list.add(new InputFoodVO("pepper","고추"));
		list.add(new InputFoodVO("kimchi","김치"));
		list.add(new InputFoodVO("kabocha","단호박"));
		list.add(new InputFoodVO("shrimp","새우"));
		list.add(new InputFoodVO("salmon","연어"));
		list.add(new InputFoodVO("corn","옥수수"));
		
		System.out.println("list.size() : " + list.size());
		int cnt = 1;
		for(InputFoodVO input : list) {
			System.out.print(cnt + " : ");
			cnt++;
			String productId = input.getEng_name();
	        String productDisplayName = input.getKor_name(); 
	        
			
			GoogleProductSetManagement.createProduct(
					projectId
					, computeRegion
					, productId
					, productDisplayName
					, productCategory
					);			
			
			GoogleProductSetManagement.addProductToProductSet(
					projectId
					, computeRegion
					, productId
					, productSetId);
		 
		
			for(int i=1; i<=20; i++) {
				try {
					String referenceImageId = productId + (i>9 ? i: "0"+i);
					String gcsUri = 
							"gs://my-project0228-269601/foods/" + productId + "/" + referenceImageId + ".jpg";
					GoogleProductSetManagement.createReferenceImage(
							projectId
							, computeRegion
							, productId
							, referenceImageId
							, gcsUri);					
				} catch(IOException e) {
					continue;
				}	
			}
			
		}

		Storage storage = StorageOptions.getDefaultInstance().getService();

	    // The name of a bucket, e.g. "my-bucket"
	    // String bucketName = "my-bucket";

	    // Select all fields
	    // Fields can be selected individually e.g. Storage.BucketField.NAME
	    Bucket bucket = storage.get("my-project0228-269601" 
	    		, BucketGetOption.fields(Storage.BucketField.values()));	

	    // Print bucket metadata
	 
	    System.out.println("BucketName: " + bucket.getName());
	    System.out.println("Id: " + bucket.getGeneratedId());
	    System.out.println("IndexPage: " + bucket.getIndexPage());
	    System.out.println("Location: " + bucket.getLocation());
	    System.out.println("Metageneration: " + bucket.getMetageneration());
	    System.out.println("NotFoundPage: " + bucket.getNotFoundPage());
	    System.out.println("RequesterPays: " + bucket.requesterPays());
	    System.out.println("SelfLink: " + bucket.getSelfLink());
	    System.out.println("StorageClass: " + bucket.getStorageClass().name());
	    System.out.println("TimeCreated: " + bucket.getCreateTime());
	    System.out.println("VersioningEnabled: " + bucket.versioningEnabled());
	    if (bucket.getLabels() != null) {
	      System.out.println("\n\n\nLabels:");
	      for (Map.Entry<String, String> label : bucket.getLabels().entrySet()) {
	        System.out.println(label.getKey() + "=" + label.getValue());
	      }
	    };
	}
}
