package com.memoko.integrated.imageanalysis.vo;

public class OutputFoodVO {
	
	private String name;
	private float score;
	
	
	public OutputFoodVO(String name, float score) {
		super();
		this.name = name;
		this.score = score;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	
	
	
	
	
	
}
