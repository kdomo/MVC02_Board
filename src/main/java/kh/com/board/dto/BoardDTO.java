package kh.com.board.dto;

import java.sql.Date;

public class BoardDTO {
	
	private int seq_board;
	private String title;
	private String content;
	private String writer;
	private String writer_id;
	private Date written_date;
	private int view_count;
	
	public BoardDTO() {}
	
	public BoardDTO(String title, String content, String writer, String writer_id) {
		super();
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.writer_id = writer_id;
	}
	
	public BoardDTO(int seq_board, String title, String content, String writer, String writer_id, Date written_date,
			int view_count) {
		super();
		this.seq_board = seq_board;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.writer_id = writer_id;
		this.written_date = written_date;
		this.view_count = view_count;
	}

	public int getSeq_board() {
		return seq_board;
	}
	public void setSeq_board(int seq_board) {
		this.seq_board = seq_board;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWriter_id() {
		return writer_id;
	}
	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}
	public Date getWritten_date() {
		return written_date;
	}
	public void setWritten_date(Date written_date) {
		this.written_date = written_date;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	
	
}
