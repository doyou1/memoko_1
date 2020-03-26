package com.memoko.integrated.storagetest;

import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

public class Maintest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Storage storage = StorageOptions.getDefaultInstance().getService();

		//BufferedImage paintedImg = ImageIO.read(new File("\\C:\\Users\\user\\Desktop\\carrot08.jpg"));
		BlobId blobId = BlobId.of("my-project0228-269601", "asd/asdasd.jpg");
	    BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType("image/jpeg").build();
	    //Blob blob = storage.createAcl(blobInfo, paintedImg);
		
	   //System.out.println(blob.toString());
		/*
		Page<Blob> blobs =
		        storage.list(
		            "my-project0228-269601", BlobListOption.currentDirectory(), BlobListOption.prefix("foods/양파/"));
		    if(!blobs.hasNextPage()) {
		    	System.out.println("page없음");
		    }
		
		 for (Blob blob : blobs.iterateAll()) { System.out.println("11"); }
		 */
	}

}
