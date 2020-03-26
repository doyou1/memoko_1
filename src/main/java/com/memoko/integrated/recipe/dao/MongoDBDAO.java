package com.memoko.integrated.recipe.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.regex.Pattern;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.jsoup.HttpStatusException;
import org.springframework.stereotype.Repository;

import com.memoko.integrated.recipe.vo.MongoRecipeVO;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoIterable;

@Repository
public class MongoDBDAO {
	/*
	public ArrayList<ringVO> main() throws Exception {
		
		MongoClient mongoclient = new MongoClient();
		
		// 데이터베이스 접근
		MongoDatabase db = mongoclient.getDatabase("test");
		// 컬렉션 접근
		MongoCollection<Document> test = db.getCollection("test");
	*/
		
		/*
		  int num = 4715;
		  
		  c:
		  while(num < 10001) 
		  { 
		  	try 
		  	{ 
		  		ringVO list = new ringVO(); 
		  		list = ring1.webcroll(num);
		  		num++; 
		  		System.out.println(list); 
		  		Document document = new Document(); 
		  		document.put("name", list.getListname()); 
		  		document.put("ingrd", list.getListingrd()); 
		  		document.put("amount",list.getListamount());
		  		document.put("content", list.getListcontent()); 
		  		document.put("photo", list.getListphoto()); 
		  		document.put("url", list.getListurl());
		  		document.put("num", list.getListnum()); 
		  		test.insertOne(document); 
		  	}
		  	catch(NoSuchElementException e) 
		  	{ 
		  		System.out.println((num) + "번째는 없음");
		  		num++; 
		  		continue c; 
		  	} 
		  	catch(HttpStatusException e2) 
		  	{ 
		  		System.out.println((num)+ "번째는 없음"); 
		  		num++; 
		  		continue c; 
		  	} 
		  }
		 */

		/*
		 * //1 ArrayList<BasicDBObject> coll1 = new ArrayList<BasicDBObject>();
		 * coll1.add(new BasicDBObject("ingrd.0",Pattern.compile(a))); coll1.add(new
		 * BasicDBObject("ingrd",Pattern.compile(b)));
		 * 
		 * BasicDBObject query1 = new BasicDBObject(); query1.put("$and",coll1);
		 * 
		 * // find 조회 후 결과값 반복자 획득 ArrayList<String> list1 = new ArrayList<String>();
		 * MongoCursor<Document> cursor1 = test.find(query1).iterator(); while
		 * (cursor1.hasNext()) { list1.add(cursor1.next().toJson()); }
		 * 
		 * 
		 * 
		 * 
		 * //2 ArrayList<BasicDBObject> coll2 = new ArrayList<BasicDBObject>();
		 * coll2.add(new BasicDBObject("ingrd.0",Pattern.compile(a))); coll2.add(new
		 * BasicDBObject("ingrd",Pattern.compile(c)));
		 * 
		 * BasicDBObject query2 = new BasicDBObject(); query2.put("$and",coll2);
		 * 
		 * // find 조회 후 결과값 반복자 획득 ArrayList<String> list2 = new ArrayList<String>();
		 * MongoCursor<Document> cursor2 = test.find(query2).iterator(); while
		 * (cursor2.hasNext()) { list2.add(cursor2.next().toJson()); }
		 * 
		 * 
		 * 
		 * //3 ArrayList<BasicDBObject> coll3 = new ArrayList<BasicDBObject>();
		 * coll3.add(new BasicDBObject("ingrd.0",Pattern.compile(a))); coll3.add(new
		 * BasicDBObject("ingrd",Pattern.compile(d)));
		 * 
		 * BasicDBObject query3 = new BasicDBObject(); query3.put("$and",coll3);
		 * 
		 * // find 조회 후 결과값 반복자 획득 ArrayList<String> list3 = new ArrayList<String>();
		 * MongoCursor<Document> cursor3 = test.find(query3).iterator(); while
		 * (cursor3.hasNext()) { list3.add(cursor3.next().toJson()); }
		 * 
		 * 
		 * //4 ArrayList<BasicDBObject> coll4 = new ArrayList<BasicDBObject>();
		 * coll4.add(new BasicDBObject("ingrd.0",Pattern.compile(a))); 
		 * coll4.add(new BasicDBObject("ingrd",Pattern.compile(e)));
		 * 
		 * BasicDBObject query4 = new BasicDBObject(); query4.put("$and",coll4);
		 * 
		 * // find 조회 후 결과값 반복자 획득 ArrayList<String> list4 = new ArrayList<String>();
		 * MongoCursor<Document> cursor4 = test.find(query4).iterator(); while
		 * (cursor4.hasNext()) { list4.add(cursor4.next().toJson()); }
		 */

	/*	
		
		
		String a = "소고기";
		String b = "양파";
		String c = "감자";
		String d = "고구마";
		String e = "파";

		//메인쿼리
		ArrayList<BasicDBObject> coll5 = new ArrayList<BasicDBObject>();
		coll5.add(new BasicDBObject("ingrd.0",Pattern.compile(a)));
		coll5.add(new BasicDBObject("ingrd",Pattern.compile(b)));
		BasicDBObject query5 = new BasicDBObject();
		query5.put("$and", coll5);
		
		ArrayList<Document> list5 = new ArrayList<Document>();
		MongoCursor<Document> cursor5 = test.find(query5).iterator();
		while(cursor5.hasNext())
		{
			list5.add(cursor5.next());
		}
		
//		list5.get(0).get()

		System.out.println("---------------document를 반환하여 리스트화 끝-------------------");
		ArrayList<ringVO> ringtest = new ArrayList<ringVO>();
		for (int j = 0; j < list5.size(); j++) 
		{
			ringVO result = new ringVO();
			result.setListname((String)list5.get(j).get("name"));
			result.setListingrd(list5.get(j).get("ingrd", ArrayList.class));
			result.setListamount(list5.get(j).get("amount", ArrayList.class));
			result.setListcontent(list5.get(j).get("content", ArrayList.class));
			result.setListphoto(list5.get(j).get("photo", ArrayList.class));
			result.setListurl((String)list5.get(j).get("url"));
			result.setListnum((String)list5.get(j).get("num"));
			ringtest.add(result);
		}
		
		System.out.println("------------document를 변환하여 vo객체리스트로 -----------------");
		
		Collections.shuffle(ringtest);
		
		ArrayList<ringVO> printlist = new ArrayList<ringVO>();
		printlist.add(ringtest.get(0));
		printlist.add(ringtest.get(1));
		printlist.add(ringtest.get(2));
		printlist.add(ringtest.get(3));
		printlist.add(ringtest.get(4));
		
		System.out.println(printlist.get(0));
		System.out.println(printlist.get(1));
		System.out.println(printlist.get(2));
		System.out.println(printlist.get(3));
		System.out.println(printlist.get(4));
		
		
		return printlist;
		
		
		
		
		//3월 19일
		//1. mongodb java driver 버전업 > count를 통하여 기존쿼리문 실행하기
		//2. 일단 조건에 맞는것을 메모리에 저장만 해두고, java에서 랜덤처리하여 보내주기(셔플)
		
		
		
		//db.test.find({"ingrd.0":{$regex:"고기"},"ingrd":{$regex:"양파"}}).limit(5).
		//skip(_rand()*db.test.count({"ingrd.0":{$regex:"고기"},"ingrd":{$regex:"양파"}}))
		// db.test.find({"ingrd.0":{$regex:"고기"},"ingrd":{$regex:"양파"}}).limit(5).skip(_rand()*db.test.count({"ingrd.0":{$regex:"고기"},"ingrd":{$regex:"양파"}}))
		// db.test.find({"ingrd.0":{$regex:"양파"}}).limit(10).skip(_rand()*db.test.count({"ingrd.0":{$regex:"양파"}}))
		// 결과중에 10개를 랜덤으로 출력하는것
		// find : 랜덤으로출력가능
		// aggregate : 20개랜덤으로출력가능, 조건을 덧붙이는것은안됨
		// array만 출력되는데 array0번을 어케하지
	}
	
*/	
	
	//스트링아무거나 넣어봐
	public ArrayList<MongoRecipeVO> findRecipeList(ArrayList<String> list) throws Exception
	{
		MongoClient mongoclient = new MongoClient();
		
		// 데이터베이스 접근
		MongoDatabase db = mongoclient.getDatabase("test");
		// 컬렉션 접근
		MongoCollection<Document> test = db.getCollection("test");
		
		//메인쿼리
		ArrayList<BasicDBObject> coll5 = new ArrayList<BasicDBObject>();
		coll5.add(new BasicDBObject("ingrd.0",Pattern.compile(list.get(0))));
		
		for(int i =1; i<list.size(); i++) {
			coll5.add(new BasicDBObject("ingrd",Pattern.compile(list.get(i))));		
		}
		BasicDBObject query5 = new BasicDBObject();
		query5.put("$and", coll5);
		
		ArrayList<Document> list5 = new ArrayList<Document>();
		MongoCursor<Document> cursor5 = test.find(query5).iterator();
		while(cursor5.hasNext())
		{
			list5.add(cursor5.next());
		}
		
		//list5.get(0).get(key)
	
		System.out.println("---------------document를 반환하여 리스트화 끝-------------------");
		ArrayList<MongoRecipeVO> ringtest = new ArrayList<MongoRecipeVO>();
		for (int j = 0; j < list5.size(); j++) 
		{
			MongoRecipeVO result = new MongoRecipeVO();
			result.setListname((String)list5.get(j).get("name"));
			result.setListingrd(list5.get(j).get("ingrd", ArrayList.class));
			result.setListamount(list5.get(j).get("amount", ArrayList.class));
			result.setListcontent(list5.get(j).get("content", ArrayList.class));
			result.setListphoto(list5.get(j).get("photo", ArrayList.class));
			result.setListurl((String)list5.get(j).get("url"));
			result.setListnum((String)list5.get(j).get("num"));
			ringtest.add(result);
		}
		
		System.out.println("------------document를 변환하여 vo객체리스트로 -----------------");
		
		Collections.shuffle(ringtest);
		
		ArrayList<MongoRecipeVO> printlist = new ArrayList<MongoRecipeVO>();
		
		for(MongoRecipeVO vo : ringtest) {
			printlist.add(vo);
		}	
		System.out.println("printlist.size() : " + printlist.size());
		return printlist;
	}
/*	
	public void croll() throws Exception
	{
		MongoClient mongoclient = new MongoClient();
		
		// 데이터베이스 접근
		MongoDatabase db = mongoclient.getDatabase("test");
		// 컬렉션 접근
		MongoCollection<Document> test = db.getCollection("test");
		
		
		
		  int num = 430;
		  
		  c:
		  while(num < 5800) 
		  { 
		  	try 
		  	{ 
		  		ringVO list = new ringVO(); 
		  		list = ring1.webcroll(num);
		  		num++; 
		  		System.out.println(list); 
		  		Document document = new Document(); 
		  		document.put("name", list.getListname()); 
		  		document.put("ingrd", list.getListingrd()); 
		  		document.put("amount",list.getListamount());
		  		document.put("content", list.getListcontent()); 
		  		document.put("photo", list.getListphoto()); 
		  		document.put("url", list.getListurl());
		  		document.put("num", list.getListnum()); 
		  		test.insertOne(document); 
		  	}
		  	catch(NoSuchElementException e) 
		  	{ 
		  		System.out.println((num) + "번째는 없음");
		  		num++; 
		  		continue c; 
		  	} 
		  	catch(HttpStatusException e2) 
		  	{ 
		  		System.out.println((num)+ "번째는 없음"); 
		  		num++; 
		  		continue c; 
		  	} 
		  }
	}
*/	
	
	public MongoRecipeVO readByNum(String listnum){
		
		MongoClient mongoclient = new MongoClient();
		// 데이터베이스 접근
		MongoDatabase db = mongoclient.getDatabase("test");
		// 컬렉션 접근
		MongoCollection<Document> test = db.getCollection("test");
		//"1500" = int가 아니고 스트링형식으로 입력
		BasicDBObject query = new BasicDBObject();
		query.put("num", listnum);
		MongoCursor<Document> cursor = test.find(query).iterator();
		ArrayList<Document> list = new ArrayList<Document>();
		if(cursor.hasNext())
		{
			list.add(cursor.next());
		}
		System.out.println(query);
		//System.out.println(list);
		//Document를 vo객체로
		MongoRecipeVO volist = new MongoRecipeVO();
		volist.setListname((String)list.get(0).get("name"));
		volist.setListingrd(list.get(0).get("ingrd", ArrayList.class));
		volist.setListamount(list.get(0).get("amount", ArrayList.class));
		volist.setListcontent(list.get(0).get("content", ArrayList.class));
		volist.setListphoto(list.get(0).get("photo", ArrayList.class));
		volist.setListurl((String)list.get(0).get("url"));
		volist.setListnum((String)list.get(0).get("num"));
		System.out.println(volist.getListname());
		
		return volist;
	}

}
