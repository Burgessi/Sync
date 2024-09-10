package com.pro.sync.board.ctrl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.pro.sync.alarm.service.IAlarmService;
import com.pro.sync.alarm.vo.AlarmVo;
import com.pro.sync.board.service.IBoardService;
import com.pro.sync.board.vo.BoardVo;
import com.pro.sync.board.vo.FileBoardVo;
import com.pro.sync.common.service.PagingService;
import com.pro.sync.common.vo.PagingVo;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
	
	private final IBoardService service;
	private final PagingService pservice;
	private final IAlarmService alarmService;
	

	
	//게시글 전체 조회
	@GetMapping(value = "/userBoard.do")
	
	public String userBoard(@RequestParam(value = "page", defaultValue  = "1") int page,
            				@RequestParam(value = "countRow", defaultValue = "10") int countRow,
            				@RequestParam(value = "countPage", defaultValue = "5") int countPage,
            				Model model){
		log.info("자유게시판으로 이동");
		
		int boardCount = service.totalCount();
		List<BoardVo> blist = service.selectBoard(page, countRow);

		PagingVo paging = pservice.page(countPage, boardCount, countRow, page);
		model.addAttribute("blist", blist);
		model.addAttribute("paging", paging);
		
		return "board/userBoard";
	}
	
	//게시글 상세
	@GetMapping(value = "/detailBoard.do")
	@Transactional
	public String detailBoard(Model model, String bd_seq) {
		log.info("{}번 게시글 상세보기", bd_seq);
		BoardVo detail = service.detailBoard(bd_seq);
		List<BoardVo> clist = service.selectComment(bd_seq);
		model.addAttribute("clist", clist);
		model.addAttribute("detail", detail);
		return "board/detailBoard";
	}
	
	//게시글 삭제
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value="/deleteBoard.do")
	public String deleteBoard(@RequestParam List<String> chk) {
		log.info("삭제될 게시물 {}", chk);
		int n = service.deleteBoard(chk);
		log.info("결과 {}", n);
		return "redirect:/board/userBoard.do";
	}
	
	//댓글 생성
	@PostMapping(value = "/insertComment.do")
	public String insertComment(BoardVo vo, HttpSession session) {
		log.info("댓글 생성 {}", vo);
		int n = service.insertComment(vo);
		
		if(n==1) {
			//게시글 작성자 아이디 조회
			String boardAuthorId=service.getBoardAuthorId(vo.getBd_seq());
			if(boardAuthorId!=null) {
				
				//알림 생성
				String title=vo.getBd_title();
				int bd_seq=vo.getBd_seq();
				//String content=vo.getBd_content();
				alarmService.addCommentAlarm(boardAuthorId, title, bd_seq);
			}			
			return "redirect:/board/detailBoard.do?bd_seq="+vo.getBd_seq();
		}else {
			return "redirect:/board/userBoard.do";
		}
		

		//return (n==1)?"redirect:/board/detailBoard.do?bd_seq="+vo.getBd_seq():"redirect:/board/userBoard.do";
	}
	
	//댓글 삭제
	@PostMapping(value = "/deleteComment.do")
	public String deleteComment(@RequestParam String co_post,
								@RequestParam String co_comment,
								@RequestParam String bd_seq) {
		log.info("삭제 댓글 post : {}, comment : {}, seq : {}",co_post ,co_comment, bd_seq);
		
		Map<String, Object> map = new HashMap<>();
		map.put("bd_post", co_post);
		map.put("bd_comment", co_comment);
		
		log.info("MAP 값{}", map);
		
		int n = service.deleteComment(map);
		log.info("결과 값{}", n);
		
		return (n>0)?"redirect:/board/detailBoard.do?bd_seq="+bd_seq:"redirect:/board/userBoard.do";
	}
	
	
	//댓글 수정 
	@PostMapping(value = "/modifyComment.do")
	public String modifyComment(@RequestParam String bd_seq,
								@RequestParam String co_post,
								@RequestParam String co_comment,
								@RequestParam String co_content) {
		log.info("받아오는 값 seq : {}, co_post : {}, co_comment : {}, co_content : {}", bd_seq, co_post, co_comment, co_content);
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("bd_post", co_post);
		maps.put("bd_comment", co_comment);
		maps.put("bd_content", co_content);
		
		int n = service.modifyComment(maps);
		log.info("보내는 값 : {}", maps);
		
		return (n>0)?"redirect:/board/detailBoard.do?bd_seq="+bd_seq:"redirect:/board/userBoard.do"; 
	}
	
	//게시물 검색
	@PostMapping(value = "/searchBoard.do")
	@ResponseBody
	public String searchBoard(@RequestParam Map<String, Object> map) {
		log.info("작성자 or 게시물 검색 : {}", map);
		List<BoardVo> searchBoard = service.searchBoard(map);
		
		Gson gson = new GsonBuilder().create();
		
		return gson.toJson(searchBoard);
	}
	
	//게시물 작성 페이지 이동
	@GetMapping(value = "/insertBoard.do")
	public String insertBoard() {
		log.info("게시물 작성 페이지 이동");
		return "board/insertBoard";
	}
	
	//게시물 생성
	@PostMapping(value = "/insertBoard.do")
	@Transactional
	public String insertBoard(BoardVo bvo, @RequestParam("filename") List<MultipartFile> files, HttpServletRequest request) {
		
		log.info("넘어 오는 값 bvo : {} , fvo : {}", bvo, files);
		boolean boardInsert = false;
		List<FileBoardVo> fileList = new ArrayList<>();
		
		try {
			
			boardInsert = service.insertBoard(bvo);
			
			if(boardInsert) {
				
				String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/WEB-INF/files/");
	            File uploadDirFile = new File(path);

	            if (!uploadDirFile.exists()) {
	                uploadDirFile.mkdirs(); // 업로드 디렉토리가 없으면 생성
	            }
				for(MultipartFile file : files) {
					if(!file.isEmpty()) {
						String storeName = UUID.randomUUID().toString().replace("-", "")
											+ file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
						
						FileBoardVo fileVo = new FileBoardVo();
						fileVo.setFile_oname(file.getOriginalFilename());
						fileVo.setFile_sname(storeName);
						fileVo.setFile_size((int) file.getSize());
	                    fileVo.setFile_date(new java.sql.Date(System.currentTimeMillis()).toString());
	                    fileVo.setBd_seq(bvo.getBd_seq());
	                    fileVo.setEmp_id(bvo.getEmp_id());
	                    byte[] fileBytes = file.getBytes();
	                    fileVo.setFile_data(fileBytes);
	                    fileList.add(fileVo);
					}
				}
				log.info("저장경로 path : {} ", path);
				log.info("파일 값 : {}", fileList);
				
				if(!fileList.isEmpty()) {
				boolean filesInsert = service.fileInsert(fileList,bvo.getBd_seq(), bvo.getEmp_id());
				if(!filesInsert) {
					 throw new RuntimeException("파일 삽입 실패");
				}
				}
			} else {
				throw new RuntimeException("게시글 삽입 실패");

			}
			 return "redirect:/board/detailBoard.do?bd_seq="+bvo.getBd_seq();
			
		}catch (Exception e) {
            log.error("게시글 또는 파일 삽입 오류: ", e);
            return "redirect:/board/userBoard.do";
	}

	}
	
	@GetMapping(value = "/modifyBoard.do")
	public String modifyBoard(@RequestParam("bd_seq") String bd_Seq, Model model, HttpSession session) {
		EmployeeVo loginDto = (EmployeeVo)session.getAttribute("loginDto");
		
		BoardVo bo = service.detailBoard(bd_Seq);
		log.info("BoardVo 객체: {}", bo);
		log.info("아이디? : {}", bo.getEmp_id());
		if(bo.getEmp_id().equals(loginDto.getEmp_id())) {
			model.addAttribute("bo", bo);
			return "board/modifyBoard";
		}else {
			return "redirect:/board/userBoard.do";
		}
	}
	
	@PostMapping(value = "/deleteFile.do")
	@ResponseBody
	public int deleteFile(@RequestParam("file_seq") int file_seq) {
		return service.deleteFile(file_seq);
	}
	
	@PostMapping(value = "/modifyBoard.do")
	@Transactional
	public String modifyBoard(@ModelAttribute BoardVo board, 
							  @RequestParam("filename") List<MultipartFile> filename, 
							  HttpSession session,
							  HttpServletRequest request) {
		 EmployeeVo loginDto = (EmployeeVo)session.getAttribute("loginDto");
		 String emp_id = loginDto.getEmp_id();

		 log.info("emp_id: {}", emp_id);
		 log.info("bd_title: {}", board.getBd_title());
		 log.info("bd_content: {}", board.getBd_content());
		 log.info("파일 : {}", filename);
		 
		 Map<String, Object> map = new HashMap<>();
		 List<FileBoardVo> fileList = new ArrayList<>();
		 map.put("bd_title", board.getBd_title());
		 map.put("bd_content", board.getBd_content());
		 map.put("bd_seq", board.getBd_seq());
		 
		 boolean isb = service.modifyBoard(map);
		 log.info("값 : {}",isb);
		 
			try {
		
				if(isb) {
					
					String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/WEB-INF/files/");
		            File uploadDirFile = new File(path);

		            if (!uploadDirFile.exists()) {
		                uploadDirFile.mkdirs(); // 업로드 디렉토리가 없으면 생성
		            }
					
					
					for(MultipartFile file : filename) {
						if(!file.isEmpty()) {
							String storeName = UUID.randomUUID().toString().replace("-", "")
												+ file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
							
							FileBoardVo fileVo = new FileBoardVo();
							fileVo.setFile_oname(file.getOriginalFilename());
							fileVo.setFile_sname(storeName);
							fileVo.setFile_size((int) file.getSize());
		                    fileVo.setFile_date(new java.sql.Date(System.currentTimeMillis()).toString());
		                    fileVo.setBd_seq(board.getBd_seq());
		                    fileVo.setEmp_id(board.getEmp_id());
		                    byte[] fileBytes = file.getBytes();
		                    fileVo.setFile_data(fileBytes);
		                    fileList.add(fileVo);
						}
					}
					log.info("저장경로 path : {} ", path);
					log.info("파일 값 : {}", fileList);
					
					if(!fileList.isEmpty()) {
					boolean filesInsert = service.fileInsert(fileList,board.getBd_seq(), board.getEmp_id());
					if(!filesInsert) {
						 throw new RuntimeException("파일 삽입 실패");
					}
					}
				} else {
					throw new RuntimeException("게시글 삽입 실패");

				}
				 return "redirect:/board/detailBoard.do?bd_seq="+board.getBd_seq();
				
			}catch (Exception e) {
	            log.error("게시글 또는 파일 삽입 오류: ", e);
	            return "redirect:/board/userBoard.do";
		}
		 
	}
	
	@GetMapping(value = "/downloadFile.do")
	public ResponseEntity<Resource> downloadFile(@RequestParam("file_seq") int file_seq) {
		log.info("파일 다운로드 요청: {}", file_seq);
		
		try {
	        FileBoardVo fileBoardVo = service.selectFile(file_seq);

	        if (fileBoardVo == null) {
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	        }

	        byte[] fileData = fileBoardVo.getFile_data();
	        String originalFileName = fileBoardVo.getFile_oname();

	        ByteArrayResource resource = new ByteArrayResource(fileData);

	        HttpHeaders headers = new HttpHeaders();
	        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + originalFileName);
	        headers.add(HttpHeaders.CONTENT_TYPE, "application/octet-stream");

	        return ResponseEntity.ok()
	                .headers(headers)
	                .contentLength(fileData.length)
	                .body(resource);
	    } catch (Exception e) {
	        log.error("파일 다운로드 오류: ", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
		
	}
	
	
}
