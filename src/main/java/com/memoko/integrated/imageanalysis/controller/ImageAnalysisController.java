package com.memoko.integrated.imageanalysis.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.memoko.integrated.imageanalysis.service.FileService;
import com.memoko.integrated.imageanalysis.service.GoogleProductSetManagement;
import com.memoko.integrated.imageanalysis.service.GoogleVisionAPI;
import com.memoko.integrated.imageanalysis.service.MediaUtils;

@Controller
@RequestMapping(value="/imageanalysis")
public class ImageAnalysisController {
	
	private static final String uploadPath = "\\C:\\imageUpload";
	
	private String fullPath = null;
	private ArrayList<HashMap<String,Object>> list = null;
	private int width = 0;
	private int height = 0;

	
	private String projectId = "my-project0228-269601";
	private String computeRegion = "asia-east1";
	private String productSetId = "MEMOKO-FOODS-99";
	private String productSetDisplayName = "FOODS";
	private String productCategory = "general-v1";
	private String filter = "";
	
	@RequestMapping(value="/uploadImageForm",method=RequestMethod.GET)
	public String imagehome() {
		
		return "/imageanalysis/uploadImageForm";
	}

	@RequestMapping(value="/upload",method=RequestMethod.POST)
	public String upload(MultipartFile upload, HttpSession session) throws Exception {
		System.out.println("upload 시작");
		if(!upload.isEmpty()) {
			String savedFile = FileService.saveFile(upload, uploadPath);
			fullPath = "\\"+uploadPath + "\\" + savedFile;
		}
		System.out.println("fullPath : " + fullPath);
		
		if(fullPath != null) {
			list = null;
			width = 0;
			height = 0;
			
			
			BufferedImage paintedImg = ImageIO.read(new File(fullPath));
			width = paintedImg.getWidth();
			height = paintedImg.getHeight();
			System.out.println("width : "+width);
			System.out.println("height : "+height);
			System.out.println("객체들 좌표잡으러가기");
			list = GoogleVisionAPI.detectLocalizedObjects(fullPath, width, height);
			System.out.println(list);
			
			for(HashMap<String,Object> map : list) {
				int x1 = (int) map.get("x1");
				int y1 = (int) map.get("y1");
				int x2 = (int) map.get("x2");
				int y3 = (int) map.get("y3");

				BufferedImage subimage = paintedImg.getSubimage(x1, y1, x2-x1, y3-y1);
				String filePath = uploadPath+"\\"+(x1*x2*y1*y3)+".jpg";
				ImageIO.write(subimage,"jpg",new File(filePath));
				map.put("filePath", filePath);
				
				String value = GoogleProductSetManagement.getSimilarProductsFile(
						projectId
						, computeRegion
						, productSetId
						, productCategory
						, filePath
						, filter);
				map.put("value",value);

			}
		}
		return "redirect:/imageanalysis/analysisImageResult";
	}
	
	@RequestMapping(value="/analysisImageResult",method=RequestMethod.GET)
	public String result(HttpSession session, Model model) {
		
		model.addAttribute("list", list);
		model.addAttribute("width", width);
		model.addAttribute("height", height);
		return "/imageanalysis/analysisImageResult";
	}
	
	@RequestMapping(value="/display",method=RequestMethod.GET)
	public ResponseEntity<byte[]> display() throws Exception {
		
		InputStream	in = null;
		ResponseEntity<byte[]> entity = null;
		try {
			MediaType mType = null;
			HttpHeaders headers = null;
			
			String ext = fullPath.substring(fullPath.lastIndexOf(".")+1);
			mType = MediaUtils.getMediaType(ext);
			headers = new HttpHeaders();
			in = new FileInputStream(fullPath);
			if(mType != null) {
				
				headers.setContentType(mType);
			}
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			
		} catch(Exception e) {
			e.printStackTrace();
			new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			
		} finally {
			if(in != null) {
				in.close();
			}
		}
		
		return entity;
		
	}
	
}
