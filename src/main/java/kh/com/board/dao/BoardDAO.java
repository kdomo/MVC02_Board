package kh.com.board.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.board.dto.BoardDTO;


public class BoardDAO {
	private BasicDataSource bds = new BasicDataSource();
	private static BoardDAO instance = null;

	private BoardDAO() {
		String className = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "board_manager";
		String password = "manager";

		bds.setDriverClassName(className);
		bds.setUrl(url);
		bds.setUsername(username);
		bds.setPassword(password);
		bds.setInitialSize(200);
	}

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	public Connection getConnection() throws Exception {
		return bds.getConnection();
	}

	public int write(BoardDTO dto) {
		String sql = "insert into tbl_board values(seq_board.nextval,?,?,?,?,sysdate,0)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriter());
			pstmt.setString(4, dto.getWriter_id());

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<BoardDTO> selectAll(){
		String sql = "select * from tbl_board order by 1 desc";
		try( Connection con = this.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int seq_board = rs.getInt("seq_board");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String writer = rs.getString("writer");
				String writer_id = rs.getString("writer_id");
				Date written_data = rs.getDate("written_date");
				int view_count = rs.getInt("view_count");
				list.add(new BoardDTO(seq_board,title, content,writer,writer_id,written_data,view_count));
			}
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public BoardDTO selectBySeq(int seq){
		String sql = "select * from tbl_board where seq_board = ?";
		try( Connection con = this.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, seq);
			ResultSet rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				BoardDTO dto = new BoardDTO(seq,rs.getString("title"),rs.getString("content"),rs.getString("writer"),rs.getString("writer_id"),rs.getDate("written_date"),rs.getInt("view_count"));
				return dto;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public int deleteBySeq(int seq) {
		String sql = "delete from tbl_board where seq_board=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, seq);

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int modifyBySeq(int seq,String title,String content) {
		String sql="update tbl_board set title=?,content=? where seq_board=?";
		
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, seq);

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
	
	public int updateView_count(int seq) {
		String sql="update tbl_board set view_count = view_count+1 where seq_board=?";
		
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, seq);

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
	
	public ArrayList<BoardDTO> getBoardList(int startRange,int endRange){
		String sql = "select * from (select row_number() over(order by seq_board desc) 순위 ,a.* from tbl_board a) where 순위 BETWEEN ? AND ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
			while(rs.next()) {
				int seq_board = rs.getInt("seq_board");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				Date written_date = rs.getDate("written_date");
				int view_count = rs.getInt("view_count");
				list.add(new BoardDTO(seq_board,title,null,writer,null,written_date,view_count));
			}
			return list;
		}catch (Exception e) {
			e.printStackTrace();
		} return null;
	}
	
	public int countAll() {
		String sql="select count(*) from tbl_board";
		try( Connection con = this.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);){
				
				ResultSet rs = pstmt.executeQuery();
				
				if(rs.next()) return rs.getInt(1);
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
	}
	
}
