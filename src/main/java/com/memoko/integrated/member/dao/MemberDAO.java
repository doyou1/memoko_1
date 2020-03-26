package com.memoko.integrated.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.memoko.integrated.member.vo.MemberVO;

@Repository
public class MemberDAO {
	@Autowired
	   private SqlSession session;
	   
	   public int insertMember(MemberVO member) {
	      int cnt = 0;
	      try {
	         MemberMapper mapper = session.getMapper(MemberMapper.class);
	         cnt = mapper.insertMember(member);
	      }
	      catch(Exception e) {
	         e.printStackTrace();
	         
	      }
	      return cnt;
	   }

	   public MemberVO memberSelectOne(String idCheck) {
		   MemberVO member = null;
	      try {
	         MemberMapper mapper = session.getMapper(MemberMapper.class);
	         member = mapper.memberSelectOne(idCheck);
	      }
	      catch(Exception e) {
	         e.printStackTrace();
	      }
	      return member;
	   }

}
