package com.pro.sync.facilities.ctrl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.pro.sync.facilities.service.IFacilitiesService;
import com.pro.sync.facilities.vo.FacilitiesVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("fcl")
public class FacilitiesController {
	
	private final IFacilitiesService service;
	
	@Autowired
    private ServletContext servletContext;

	@GetMapping(value = "/boardFcl.do")
	public String boardFcl(Model model) {
		log.info("회의실 리스트 페이지 이동");
		List<FacilitiesVo> fclList = service.selectFcl();
		model.addAttribute("fclList", fclList);
		return "facilities/boardFcl";
	}
	
	@GetMapping(value = "/insertFcl.do")
	public String insertFcl(){
		return "facilities/insertFcl";
	}
	
	@PostMapping(value = "/insertFcl.do")
	public String insertFcl(@RequestParam("fcl_name") String fclName,
	        				@RequestParam("fcl_pic") MultipartFile file,
	        				@RequestParam("fcl_content") String fclContent) throws IOException {

		FacilitiesVo vo = new FacilitiesVo();
	    vo.setFcl_name(fclName);
	    vo.setFcl_content(fclContent);
	    vo.setFcl_able("Y"); // 기본값 설정, 필요에 따라 조정

	    // 파일이 비어있는지 확인
	    if (!file.isEmpty()) {
	        // 파일 업로드 경로 설정
	        String path = servletContext.getRealPath("/resources/upload/meetingroom");
	        File uploadDirFile = new File(path);

	        if (!uploadDirFile.exists()) {
	            uploadDirFile.mkdirs(); // 업로드 디렉토리가 없으면 생성
	        }

	        log.info("주소 : {}", uploadDirFile);

	        // 파일 이름 처리
	        String pic = file.getOriginalFilename();
	        log.info("fcl_pic : {}", pic);

	        // 파일 이름에 UUID를 추가하여 중복 방지
	        String saveFileName = UUID.randomUUID().toString()
	                .concat(pic.substring(pic.lastIndexOf(".")));
	        File saveFile = new File(uploadDirFile, saveFileName);

	        // 파일 저장
	        try (InputStream inputStream = file.getInputStream();
	               OutputStream outputStream = new FileOutputStream(saveFile)) {
	               byte[] buffer = new byte[1024];
	               int bytesRead;
	               while ((bytesRead = inputStream.read(buffer)) != -1) {
	                   outputStream.write(buffer, 0, bytesRead);
	               }
	           }

	        // 파일 URL 설정
	        String contextPath = servletContext.getContextPath();
	        String fileUrl = contextPath + "/resources/upload/meetingroom/" + saveFileName;
	        vo.setFcl_pic(fileUrl); // FacilitiesVo 객체에 파일 URL 설정
	    } else {
	        // 파일이 비어있는 경우, 기본값을 설정하거나 처리할 수 있음
	        vo.setFcl_pic(null); // 파일이 없는 경우 null로 설정
	    }

	    // FacilitiesVo 객체의 나머지 필드 설정
	    Map<String, Object> map = new HashMap<>();
	    map.put("fcl_id", vo.getFcl_id());
	    map.put("fcl_name", vo.getFcl_name());
	    map.put("fcl_able", vo.getFcl_able());
	    map.put("fcl_pic", vo.getFcl_pic());
	    map.put("fcl_content", vo.getFcl_content());
	    log.info("값 {}", map);

	    int n = service.insertFcl(map);
	    if (n > 0) {
	        return "redirect:/fcl/boardFcl.do";
	    } else {
	        return "redirect:/fcl/insertFcl.do";
	    }
	}


	
	@GetMapping(value = "/detailFcl.do")
	public String detailFcl(@RequestParam String fcl_id, Model model) {
		log.info("{}번 회의실 상세보기", fcl_id);
		FacilitiesVo detailVo = service.detailFcl(fcl_id);
		model.addAttribute("detailVo",detailVo);
		return "facilities/detailFcl";
	}
	
	@GetMapping(value = "/deleteFcl.do")
	public String deleteFcl(String fcl_id) {
		log.info("{}번 회의실 삭제", fcl_id);
		int n = service.deleteFcl(fcl_id);
		return (n>0)?"redirect:/fcl/boardFcl.do":"redirect:/fcl/detailFcl.do";
	}
	
	@PostMapping(value = "/updateFcl.do")
	public String updateFcl(String fcl_id) {
		log.info("{}번 회의실 사용불가", fcl_id);
		int n = service.updateFcl(fcl_id);
		return (n>0)?"redirect:/fcl/detailFcl.do?fcl_id="+fcl_id:"redirect:/fcl/boardFcl.do";
		
	}
	
	@GetMapping(value = "/disposableFcl.do")
	public String disposableFcl(String fcl_id) {
		log.info("{]번 회의실 사용가능");
		int n = service.disposableFcl(fcl_id);
		return (n>0)?"redirect:/fcl/detailFcl.do?fcl_id="+fcl_id:"redirect:/fcl/boardFcl.do";
	}
	
	
	
}
