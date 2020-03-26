package com.memoko.integrated.member.dao;

import com.memoko.integrated.member.vo.MemberVO;

public interface MemberMapper {
	  public int insertMember(MemberVO member);
	   public MemberVO memberSelectOne(String idCheck);
}
