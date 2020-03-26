package com.memoko.integrated.storagetest;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.google.appengine.tools.cloudstorage.GcsFilename;
import com.google.appengine.tools.cloudstorage.GcsService;
import com.google.appengine.tools.cloudstorage.GcsServiceFactory;
import com.google.appengine.tools.cloudstorage.RetryParams;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

@RequestMapping(value="/storage")
@Controller
public class StorageController {
	 
	  
	@RequestMapping(value="/uploadFile",method=RequestMethod.POST)
	public String uploadFile(MultipartFile upload) throws IOException {
	    
		System.out.println("upload.getOriginalFilename() : " + upload.getOriginalFilename());
		Storage storage = StorageOptions.getDefaultInstance().getService();
		  
		BlobId blobId = BlobId.of("my-project0228-269601", "asd.jpg");
	    BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType("image/jpeg").build();
	    //Blob blob = storage.create(blobInfo, "Hello, Cloud Storage!".getBytes("utf-8"));
	    Blob blob = storage.create(blobInfo, upload.getBytes());
		
	    System.out.println(blob.toString());
		return "redirect:/";
	}

	@RequestMapping(value="/uploadFileForm",method=RequestMethod.GET)
	public String uploadFileForm() {
		
		
		return "/storage/uploadFileForm";
	}
	
	
}
