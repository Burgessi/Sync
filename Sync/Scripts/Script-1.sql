--APPROVAL INSERT 


INSERT INTO APPROVAL
			(APPROVAL_ID, DOCUMENT_TYPE, APPROVAL_CONTENT, 
			TEMP_SAVE_FLAG, DELETE_FLAG, REQUESTER_ID, 
			REQUEST_DATE)
	VALUES((SELECT TO_CHAR(CURRENT_DATE,'YYYYMMDD') || LPAD(COALESCE(SUBSTR(MAX(APPROVAL_ID),-3),'0') + 1,3,'0') 
	FROM APPROVAL), '휴가신청서', '{"title":"휴가신청서","content":"hello"}', 
				'N'	, 'N'	, '김사원', 
				CURRENT_DATE);

			
			
			
			
SELECT TO_CHAR(CURRENT_DATE,'YYYYMMDD') 
	FROM DUAL;

SELECT LPAD(COALESCE(SUBSTR(MAX(APPROVAL_ID),-3),0)+1,3,'0')
	FROM APPROVAL a 

SELECT TO_CHAR(CURRENT_DATE,'YYYYMMDD') || LPAD(COALESCE(MAX(APPROVAL_ID),'0') + 1,3,'0')
	FROM APPROVAL;



SELECT TO_CHAR(CURRENT_DATE,'YYYYMMDD') || LPAD(COALESCE(SUBSTR(MAX(APPROVAL_ID),-3),'0') + 1,3,'0') 
	FROM APPROVAL a;



--APPROVAL CONTENT에서 JSON VALUE 추출하는 방법 알리아스 이용해서 각각 미리 만들어서 추출하기

SELECT JSON_VALUE(APPROVAL_CONTENT , '$.content') AS content
	FROM APPROVAL a 

	
	
	
	
	
SELECT *
	FROM EMPLOYEE JOIN TEAM  
	ON EMPLOYEE.TEAM_CODE = TEAM.TEAM_CODE 
	JOIN "RANK" r 
	ON EMPLOYEE.RANK_ID = r.RANK_ID 
	
	
ALTER TABLE EMPLOYEE ADD EMP_LEAD CHAR(1);
