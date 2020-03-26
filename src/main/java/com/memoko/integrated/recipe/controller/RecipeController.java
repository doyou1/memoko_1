package com.memoko.integrated.recipe.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.memoko.integrated.imageanalysis.service.FileService;
import com.memoko.integrated.recipe.dao.MongoDBDAO;
import com.memoko.integrated.recipe.dao.RecipeDAO;
import com.memoko.integrated.recipe.vo.MongoRecipeVO;
import com.memoko.integrated.recipe.vo.RecipeContentVO;
import com.memoko.integrated.recipe.vo.RecipeIngrdVO;
import com.memoko.integrated.recipe.vo.RecipeVO;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value="/recipe")
public class RecipeController {
	
	private static final Logger logger = LoggerFactory.getLogger(RecipeController.class);
	private static final String uploadPath = "\\C:\\recipeUpload";
	
	@Autowired
	private MongoDBDAO mongodao;

	@Autowired
	private RecipeDAO recipedao;
	
	//입력, 리스트출력
	@RequestMapping(value="/findRecipeList", method=RequestMethod.POST)
	public String findRecipeList(String[] food,Model model) throws Exception
	{
		ArrayList<String> list = new ArrayList<String>();
		for(String f : food) {
			if(f != null || f != "") {
				list.add(f);
			}
		}
		
		ArrayList<MongoRecipeVO> recipeList = mongodao.findRecipeList(list);
		
		model.addAttribute("recipeList", recipeList);
		
		return "/recipe/recipeListForm";
	}
	
	
	@RequestMapping(value="/recipeReadForm",method=RequestMethod.GET)
	public String recipeReadForm(String listnum,Model model) {
		MongoRecipeVO recipe = mongodao.readByNum(listnum);
		model.addAttribute("recipe", recipe);
		
		return "/recipe/recipeReadForm";
	}
	
	@RequestMapping(value="/insertRecipeForm",method=RequestMethod.GET)
	public String insertRecipeForm() {
		
		return "/recipe/insertRecipeForm";
	}

	@RequestMapping(value="/insertRecipe",method=RequestMethod.POST)
	public String insertRecipe(String recipe_title
			, ArrayList<MultipartFile> recipe_image
			, String[] recipe_content
			, String[] ingrd_name
			, String[] ingrd_amount
			,HttpSession session) {
		System.out.println("recipe_title : " + recipe_title);
		System.out.println("recipe_image : " + recipe_image.size());
		System.out.println("recipe_content : " + recipe_content.length);

		String member_id = (String) session.getAttribute("userId");
		System.out.println("member_id : " + member_id);
		
		System.out.println("==insert 시작 ==");
		RecipeVO recipe = new RecipeVO();
		
		recipe.setMember_id(member_id);
		recipe.setRecipe_title(recipe_title);
		
		int check = recipedao.insertRecipe(recipe);
		
		//selectkey를 통해 방금 insert한 recipe_num 리턴받음
		if(check > 0) {
			System.out.println("recipe_num : (seq) : " + recipe.getRecipe_num());
			int recipe_num = recipe.getRecipe_num();

			System.out.println("recipe_image size : " + recipe_image.size());
			System.out.println("recipe_content size : " + recipe_content.length);

			//레시피 컨텐츠 시퀀스 0으로
			System.out.println("레시피컨텐츠시퀀스 초기화 시작");
			recipedao.resetContentSeq();
			System.out.println("레시피컨텐츠시퀀스 초기화 끝");		
			for(int i = 0; i < recipe_image.size(); i++) {
				RecipeContentVO contentVO = new RecipeContentVO();
				contentVO.setMember_id(member_id);
				
				MultipartFile image = recipe_image.get(i);
				String content = recipe_content[i];
				
				contentVO.setRecipe_num(recipe_num);
				
				//content가 비어있지 않다면
				if(content != null && content != "") {
					contentVO.setRecipe_content(content);
				}
				//image가 비어있지 않다면
				if(!image.isEmpty()) {
					String imagePath = FileService.saveFile(image, uploadPath);
					System.out.println("imagePath : " + imagePath);
					contentVO.setRecipe_image(imagePath);
				}
								
				check = recipedao.insertRecipeContent(contentVO);
				if(check > 0) {
					System.out.println("Content INSERT 성공!");
				}
			}
			System.out.println("CONTENTS INSERT 완료");
			System.out.println("레시피컨텐츠시퀀스 초기화 시작");
			recipedao.resetIngrdSeq();
			System.out.println("레시피컨텐츠시퀀스 초기화 끝");			
			
			for(int i = 0; i < ingrd_name.length; i++) {
				String name = ingrd_name[i];
				String amount = ingrd_name[i];
				
				RecipeIngrdVO ingrdVO = new RecipeIngrdVO();
				ingrdVO.setRecipe_num(recipe_num);
				ingrdVO.setMember_id(member_id);
				ingrdVO.setIngrd_name(name);
				ingrdVO.setIngrd_amount(amount);
				
				check = recipedao.insertRecipeIngrd(ingrdVO);
				if(check > 0) {
					System.out.println("Ingrd INSERT 성공!");
				}
			}
			
			System.out.println("INGRDS INSERT 완료");
		}
				
		return "redirect:/";
	}
	
	
}
