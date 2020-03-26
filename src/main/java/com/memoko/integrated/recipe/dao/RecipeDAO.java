package com.memoko.integrated.recipe.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.memoko.integrated.recipe.vo.RecipeContentVO;
import com.memoko.integrated.recipe.vo.RecipeIngrdVO;
import com.memoko.integrated.recipe.vo.RecipeVO;

@Repository
public class RecipeDAO {

	@Autowired
	private SqlSession session;
	
	public int insertRecipe(RecipeVO recipe) {
		int check = 0;
		
		try {
			RecipeMapper mapper = session.getMapper(RecipeMapper.class);
			check = mapper.insertRecipe(recipe);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return check;
	}
	
	
	public int insertRecipeContent(RecipeContentVO contentVO) {
		int check = 0;
		
		try {
			RecipeMapper mapper = session.getMapper(RecipeMapper.class);
			check = mapper.insertRecipeContent(contentVO);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return check;
	}
	
	public int insertRecipeIngrd(RecipeIngrdVO ingrdVO) {
		int check = 0;
		
		try {
			RecipeMapper mapper = session.getMapper(RecipeMapper.class);
			check = mapper.insertRecipeIngrd(ingrdVO);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return check;
	}

	
	public void resetContentSeq() {
		
		try {
			RecipeMapper mapper = session.getMapper(RecipeMapper.class);
			mapper.dropContentSeq();
			mapper.createContentSeq();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

	public void resetIngrdSeq() {
		
		try {
			RecipeMapper mapper = session.getMapper(RecipeMapper.class);
			mapper.dropIngrdSeq();
			mapper.createIngrdSeq();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}
}
