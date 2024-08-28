package com.pro.sync.common.service;

import org.springframework.stereotype.Service;
import com.pro.sync.common.vo.PagingVo;

@Service
public class PagingService {

	public PagingVo page(int countPage, int totalCount, int countRow, int currentPage) {
	    PagingVo paging = new PagingVo(); // 새로운 PagingVo 객체를 생성
	    
	    int totalPage = (int) Math.ceil((double) totalCount / countRow); // 전체 페이지 수를 계산
	    int startPage = ((currentPage - 1) / countPage) * countPage + 1; // 현재 페이지 그룹의 시작 페이지를 계산
	    int endPage = Math.min(startPage + countPage - 1, totalPage); // 현재 페이지 그룹의 끝 페이지를 계산합니다. (전체 페이지 수를 초과X)
	    
	    paging.setPage(currentPage); // 현재 페이지를 설정하는것
	    paging.setTotal(totalCount); // 전체 데이터 수를 설정하는것
	    paging.setCountRow(countRow); // 페이지 당 데이터 수를 설정하는것
	    paging.setCountPage(countPage); // 페이지 그룹의 페이지 수를 설정하는것
	    paging.setTotalPage(totalPage); // 전체 페이지 수를 설정하는것
	    paging.setStartPage(startPage); // 현재 페이지 그룹의 시작 페이지를 설정하는것
	    paging.setEndPage(endPage); // 현재 페이지 그룹의 끝 페이지를 설정하는것
	    
	    return paging; // 설정된 PagingVo 객체를 리턴
	}

}

