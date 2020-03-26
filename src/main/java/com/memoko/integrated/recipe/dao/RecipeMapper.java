package com.memoko.integrated.recipe.dao;


import com.memoko.integrated.recipe.vo.RecipeContentVO;
import com.memoko.integrated.recipe.vo.RecipeIngrdVO;
import com.memoko.integrated.recipe.vo.RecipeVO;

public interface RecipeMapper {

	public int insertRecipe(RecipeVO recipe);
	public int insertRecipeContent(RecipeContentVO contentVO);
	public int insertRecipeIngrd(RecipeIngrdVO ingrdVO);
	public void dropContentSeq();
	public void createContentSeq();	
	public void dropIngrdSeq();
	public void createIngrdSeq();
	
}
