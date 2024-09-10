# Sync Company
> ### 그룹웨어 프로젝트
 #### 그룹웨어 프로그램을 참고하여 기획하고 여러 기능을 추가하여
 #### 원활한 의사소통과 정보 공유와 신속한 의사 결정이 이루어질 수 있는 업무 환경을 제공하며
 
#### 편리하게 이용할 수 있는 그룹웨어 시스템을 만들자는 목표로 프로젝트를 기획하였습니다.



# 개발환경 & 사용기술

##### *1.Language* : JAVA, JavaScript, SQL, CSS, HTML, JSP

##### *2.Development Tool* : Eclipse, DBeaver

##### *3.Test Tool* : Post Man

##### *4.Server* : Apache Tomcat 9.0

##### *5.DB oracle* : Oracle 21c

##### *6. Front-End* : JSP, Ajax, Jquery, BootStrap, SweetAlert2, Toastr, Jstl

##### *7. Back-end* : Spring Framework, MyBatis, gson, json-simple, commons-fileupload, Mail, Lombok, WebSocket, AOP

##### *8.API* : JsTree, ckEditor5, HTML2PDF, Signature Pad, FullCalendar API, Google Calendar API, Kakao 주소 API, DataTables

# ERD

# 팀원별 담당
### 🧑‍💻원영인

#### - Git 관리 : repository 생성 및 Github를 통한 형상관리

#### - DB 설계 담당 : 관계형 데이터베이스 설계 / ERD를 통한 물리 DB 설계 및 구축, 관리

#### - UI 설계 및 구현

 #### 📂자유게시판
###### 
 <details>
  <summary>접기/펼치기</summary> 
  (https://github.com/Burgessi/Sync/tree/main/Sync/src/main/java/com/pro/sync/board)
  <img width="1265" alt="자유게시판" src="https://github.com/user-attachments/assets/ffcaa9e8-1397-4ab0-af00-d3a439d5a0e6">
 </details>
 
  * #### 조회/상세보기/작성/수정/삭제 구현
    * ###### commons-fileupload 업로드 / 다운로드 구현, ckEditor5 사용
  * #### 페이징/체크박스/검색/댓글(생성/수정/삭제) 구현
    * ###### Gson으로 검색 기능 구현 
 #### 📂공지게시판
###### 
 <details>
  <summary>접기/펼치기</summary> 
  (https://github.com/Burgessi/Sync/tree/main/Sync/src/main/java/com/pro/sync/notice)
  <img width="1259" alt="공지게시판" src="https://github.com/user-attachments/assets/9952455d-0eca-4ca2-a6e9-bdde602965b0">
 </details>
 
  * #### 조회/상세보기/작성/수정/삭제 구현
     * ###### 관리자가 상단에 5개까지 고정/내리기 기능 구현, ckEditor5 사용
   * #### 페이징/체크박스/검색 기능 구현
     * ###### Gson으로 검색 기능 구현 
 #### 📂일정관리
 ###### 
 <details>
  <summary>접기/펼치기</summary> 
  (https://github.com/Burgessi/Sync/tree/main/Sync/src/main/java/com/pro/sync/plan)
  <img width="1263" alt="일정" src="https://github.com/user-attachments/assets/ae2e20c4-806a-4ba8-86b2-92815640af1d">
 </details>
 
   * #### FullCalendar API를 이용하여 캘린더 구현
   * #### 조회/등록/수정/삭제 구현
      * ###### Ajax를 이용한 비통기 통신
 #### 📂시설예약
  ###### 
 <details>
  <summary>접기/펼치기</summary> 
  (https://github.com/Burgessi/Sync/tree/main/Sync/src/main/java/com/pro/sync/reservations)
  <img width="1246" alt="회의실" src="https://github.com/user-attachments/assets/8f3cd0a7-a71b-4c53-a0f2-2ae5f7d76309">
 </details>
 
   * #### FullCalendar API를 이용하여 전체 예약현황 구현
   * #### 회의실 리스트 조회/생성/수정/삭제 구현
      * ###### 자신이 예약한 회의실 리스트 조회 / 현재 사용 중인 회의실 리스트 조회 / 예약 시 시간대 중복검사 기능 구현
### 🧑‍💻박강륜

#### - DB 설계 담당 : 관계형 데이터베이스 설계 / ERD를 통한 물리 DB 설계 및 구축, 관리

#### - UI 설계 및 구현

 #### 📂전자결재
 ###### 
 <details>
  <summary>접기/펼치기</summary> 
  (https://github.com/Burgessi/Sync/tree/main/Sync/src/main/java/com/pro/sync/approval)
  <img width="943" alt="전자결재" src="https://github.com/user-attachments/assets/f2bb3fbd-297f-4e30-9523-92ce32e8a9d4">
 </details>

 * #### 전자결재 공통 기능
    * ###### DataTables API를 통한 결재 목록 검색 및 페이징
 * #### 기안문 작성
    * ###### Datepicker를 활용한 날짜 설정
    * ###### Jstree를 통한 결재자, 참조자 지정
    * ###### 임시저장 / 상신 기능
 * #### 기안 문서함
    * ###### 결재가 이루어지지 않은 상태에서만 내용 수정 및 결재 회수
    * ###### 결재 완료 시 HTML2PDF를 통한 PDF저장
 * #### 수신 문서함
    * ###### 결재자의 경우 결재 순서일 때에만 문서 조회 가능
    * ###### 결재 승인 시 signature_pad를 통한 서명 입력 기능 구현 / 결재 반려 기능
 * #### 임시 저장함
    * ###### 임시저장된 문서를 계속 작성 / 회수
    * ###### 계속 작성 시 결재선 재지정을 통한 문서 상신
 #### 📂채팅
 ###### 
 <details>
  <summary>접기/펼치기</summary> 
  (https://github.com/Burgessi/Sync/tree/main/Sync/src/main/java/com/pro/sync/chat)
  <img width="944" alt="채팅" src="https://github.com/user-attachments/assets/811ce3f7-6467-4142-b369-0b356cd23c37">
 </details>

 * #### Spring Websocket을 이용한 실시간 그룹 채팅
 * #### 채팅방 생성/사원 초대/채팅방 나가기 기능 구현
 * #### 채팅 참여자 목록 표시
### 👩‍💻황채영

#### - DB 설계 담당 : 관계형 데이터베이스 설계 / ERD를 통한 물리 DB 설계 및 구축, 관리

#### - UI 설계 및 구현

 #### 📂인사관리

 #### 📂알림
### 👩‍💻정다정

#### - DB 설계 담당 : 관계형 데이터베이스 설계 / ERD를 통한 물리 DB 설계 및 구축, 관리

#### - UI 설계 및 구현

 #### 📂로그인/로그아웃

 #### 📂근태관리
  
 #### 📂마이페이지

 #### 📂메인페이지



  

