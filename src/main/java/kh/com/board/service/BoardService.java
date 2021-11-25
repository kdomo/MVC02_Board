package kh.com.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import kh.com.board.dao.BoardDAO;
import kh.com.board.dto.BoardDTO;

public class BoardService {
//request,response 랑 직접적인 관련이 없는
// 특정한 객체(Board)와 관련된 비지니스 로직을 여기,Service 에서만 처리

	private BoardDAO dao = BoardDAO.getInstance();
	private int recordCntPerPage = 10; //한 페이지에 몇개의 레코드가 들어갈지
	private int naviCntPerPage = 10; //네비게이션에 몇개씩 보여줄지

	public HashMap<String,Object> getPageNavi(int currentPage){
		int recordTotalCnt = dao.countAll(); // 전체 레코드의 수를 가져옴
		int pageTotalCnt; //총 몇페이지가 나올지
		
		if(recordTotalCnt % recordCntPerPage > 0) {
			pageTotalCnt = recordTotalCnt/recordCntPerPage + 1;
		}else {
			pageTotalCnt = recordTotalCnt/recordCntPerPage;
		}
		
		if(currentPage < 1) { //만약 현재 페이지가 1보다 작다면
			currentPage = 1; //현재페이지를 강제로 1로 설정
		}else if(currentPage > pageTotalCnt) { //만약 현재페이지가 전체페이지보다 크다면
			currentPage = pageTotalCnt; //현재페이지를 마지막페이지로 설정
		}
		
		int startNavi = ((currentPage - 1)/naviCntPerPage) * naviCntPerPage +1;
		int endNavi = startNavi * naviCntPerPage;
		
		if(endNavi > pageTotalCnt) { //만약 endnavi가 총 페이지보다 크다면
			endNavi = pageTotalCnt; //endnavi를 마지막페이지로 설정
		}
		
		boolean needPrev = true; //이전페이지 버튼
		boolean needNext = true; //다음페이지 버튼
		
		if(startNavi == 1) { //네비의 시작이 1이라면
			needPrev = false; //이전페이지버튼 필요없음
		}
		if(endNavi == pageTotalCnt) { //네비의 마지막이 전체 페이지와 같다면
			needNext = false; //다음페이지 버튼 필요없음
		}
		
		System.out.println("startNavi : " + startNavi);
		System.out.println("endNavi : " + endNavi);
		System.out.println("needPrev : " + needPrev);
		System.out.println("needNext : " + needNext);
		
		HashMap<String,Object> map = new HashMap<>();
		map.put("startNavi",startNavi);
		map.put("endNavi",endNavi);
		map.put("needPrev",needPrev);
		map.put("needNext",needNext);
		map.put("currentPage",currentPage);
		return map;
	}
	
	
	public ArrayList<BoardDTO> getBoardList(int currentPage){

		int startRange = currentPage * recordCntPerPage - (recordCntPerPage-1);
		int endRange =  currentPage * recordCntPerPage;
		
		ArrayList<BoardDTO> list =  dao.getBoardList(startRange,endRange);
	
		for(BoardDTO dto : list) {
			System.out.println(dto.getSeq_board() +" : "+ dto.getTitle()+" : "+dto.getWriter()+" : "+dto.getWritten_date()+" : "+dto.getView_count());
		}
		
		return list;
		
	}
}
