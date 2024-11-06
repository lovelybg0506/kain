<!--
/******************************************************************************
**  프로그램명 	: ZA0030_VX.jsp
**  내      용 	: 부실채권원장관리
**  작  성  자 	: 강병규
**  작  성  일 	: 2024/05/27
**  Version    	: 1.0
*******************************************************************************
**  변경이력		: 
*******************************************************************************/
-->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>

<!-- ***************************************************************************
** 기본 Include File : 모든 JSP 파일에 사용  (Fixed)
***************************************************************************** -->
<%@ page import="comm.utils.NaviString"%>		<!-- 화면경로를 표시하기 위한 유틸 -->
<%@ page import="comm.utils.CodeUtil"%>			<!-- 공통코드 유틸 -->
<%@ page import="comm.utils.Tool"%>				<!-- 공통유틸 -->
<%@ page import="comm.utils.LanguagePack" %>	<!-- 태그관련 유틸 -->
<%@ page import="comm.utils.ButtonHandler" %>	<!-- 버튼권한관련 유틸 -->
<!-- ************************************************************************ -->

<!-- session User Information : 로그인시 저장된 사용자정보 -->
<%@ include file="/autocomm/inc/getSessionInfo.jsp"	%>

<!-- ***************************************************************************
** 공통  class load block (Fixed)
***************************************************************************** -->
<%
	/* 화면경로를 표시하기 위한 부분 */
	NaviString navi   = new NaviString(sessionBrchCode, sessionMenuID, "ZA0030_VX");
	/* 버튼별 권한관리를 위한 버튼핸들러 */		
	ButtonHandler btc = new ButtonHandler(sessionUserinfoVector, sessionMenuID);
%>

<!-- ***************************************************************************
** 리스트박스 콤보 등 기타 class load block
***************************************************************************** -->
<%
    /* 리스트박스(콤보)를 표시하기위한 부분 */
    CodeUtil SY31 = new CodeUtil("SY3100000");    // 결재상태[SY31]
    CodeUtil CM03 = new CodeUtil("CM0300000");    // 관리본지점
    CodeUtil CM04 = new CodeUtil("CM0400000");    // 부서
    CodeUtil ZA01 = new CodeUtil("ZA0100000");    // 채무상태
    CodeUtil ZA02 = new CodeUtil("ZA0200000");    // 채권구분(부실채권)
    CodeUtil ZA06 = new CodeUtil("ZA0600000");    // 부실채권취득분류
    CodeUtil ZA90 = new CodeUtil("ZA900000");	// NPL상세코드 [ZA90]
    		
    SY31.remove("SY310001");
    SY31.remove("SY310003");
    SY31.remove("SY310004");
%>
<!-- ***************************************************************************
** 파라메터 Set block
***************************************************************************** -->
<%
%>

<html>
<head>
<!-- ***************************************************************************
** 모든 JSP 파일에 공통사용 (Fixed)
***************************************************************************** -->
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>부실채권원장관리</title>
<link rel="stylesheet" href="/autocomm/css/css.css" type="text/css">

<!-- [ Default ] common & DataSet, TrSet, grid  -->
<%@ include file="/autocomm/inc/base_js.jsp"%>

<!-- ***************************************************************************
** Gauce 사용 관련 JSP : condSet, dataSet, trSet 관련 include 정의
***************************************************************************** -->
<jsp:include flush="true" page="/autocomm/inc/base/dataSet.jsp?id=condSet" />
<jsp:include flush="true" page="/autocomm/inc/base/dataSet.jsp?id=dataSet01,dataSet02" />
<jsp:include flush="true" page="/autocomm/inc/base/trSet.jsp?id=trSet01,trSet02" />

<%@ include file="/autocomm/inc/codeUtil.jsp"%>			<!-- 상세코드 -->
<%@ include file="/autocomm/inc/setCMBASUSR.jsp"%>		<!-- 사용자ID 검증 및 사용자 POP-UP -->
<!-- ***************************************************************************
** JavaScript Block : 기본 JavaScript 함수만 구현한다. 업무별 Javascript는 아래 Block사용
***************************************************************************** -->
<%=btc.print() %>		<!-- 버튼관련 자바스크립트 생성 ButtonHandler -->

<script language="javascript">

<!-- Page Load시 실행 되는 공통 function 				-->
<!-- Handler, initDataSet, initTransSet 등 구현 		-->
function initWindow()
{
	setButtonHandler();				// 버튼 핸들러 등록
	setEventHandler();				// 이벤트 핸들러 등록
	
	grdSheet01.ToolTip  = "use=true;alt=true;edgecolor=transparent;width=700;color=#ffffff;backcolor=transparent;fontsize=10;createtime=100;destroytime=10000;topmargin=10;bottommargin=10;leftmargin=10;rightmargin=10";
	grdSheet01.Format	= '' +
		'<FC>id="EXCFLDNBR"		name="계약번호" 			width="100"	align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} sumtext=@count </FC> ' +
		'<FC>id="CUSTMRCDE"		name="고객번호" 			width="70"	align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</FC> ' +
		'<FC>id="CUSTMRCDE_NM"	name="고객명" 			width="150"	align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</FC> ' +
		'<C>id="SIGPROSTS_NM" 	name="결재상태" 			width="100"	align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="CLDOWNKND_NM" 	name="채권구분" 			width="100"	align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="CLDOWPKND_NM" 	name="현재채권구분" 		width="110"	align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="CLDISDEBS_PRE" 	name="현재채무상태" 		width="100"	align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}, Color={decode(FILFLDSTA, "CM940003", "Red", "black")} </C> ' +
		'<C>id="IRLCRSSTS_NM" 	name="개회/신복상태" 		width="100"	align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}, Color={decode(FILFLDSTA, "CM940003", "Red", "black")} </C> ' +
		
		//'<C>id="CLDISDEBS_NM" name="채무상태" 			width="100"	align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="CLDISDCYN" 		name="종결Y/N" 			width="70"	align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}, Color={decode(FILFLDSTA, "CM940003", "Red", "black")} </C> ' +
		'<C>id="CLDOCRKND_NM" 	name="취득분류" 			width="120" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="LOSTOTAMT" 		name="최초합계" 			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="PURPAYAMT" 		name="매입가"			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +

		'<C>id="COLWONAMT_G" 	name="현재;회수원금" 			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="COLLOCAMT_G" 	name="현재;회수법비용" 		width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="COLWONIJA_G" 	name="현재;회수미수이자"		width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="COLTOTAMT_G"	name="현재;회수합계" 			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="DEDWONAMT_G"	name="현재;감면원금" 			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="DEDLOCAMT_G"	name="현재;감면법비용"		width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="DEDWONIJA_G"	name="현재;감면미수이자"		width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="DEDTOTAMT_G"	name="현재;감면합계" 			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="CLDCLOLAM_G"	name="현재;대손처리금액"	width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="NOWWONAMT_G"	name="현재원금"			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="NOWLOCAMT_G"	name="현재법비용" 		width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="NOWWONIJA_G"	name="현재미수이자" 		width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="NOWTOTAMT_G"	name="현재합계" 			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
				
		'<C>id="REPDIVTNO" 		name="화해총회차"			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="REPDIVPNO_P" 	name="경과회차"			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="REPDIVPNO" 		name="납부회차"			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="REPDIVAMT_P" 	name="연체금액"			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +

		'<C>id="MGTMINBRH_NM" 	name="관리본지점" 		width="80" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="MGTFLDDPT_NM" 	name="부서" 				width="80" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="MGTPSNDID_NM" 	name="담당자" 			width="80" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +

		'<C>id="DLYFLDDAY" 		name="연체일수" 			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="REGACCVNO" 		name="등록전표번호"		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#83d7f4 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="EXCFLDNB1" 		name="(자체)실행번호"		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="TRSCLDDAT" 		name="매입/이관일" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="BOJEUNGNM" 		name="보증인" 			width="100" align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="DISPURCNC_NM" 	name="매입처명" 			width="120" align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="FINROICDE_NM" 	name="가상계좌은행" 		width="100" align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="DEPACDNBR" 		name="모계좌번호" 		width="100" align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="IMAACDNBR" 		name="가상계좌번호" 		width="100" align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="CRTFUPDAT" 		name="완제일" 			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +

		'<C>id="CLDRESDAT" 		name="환매일" 			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="CLDRESAMT" 		name="환매대금"			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="CLDRESDID_NM"	name="환매처리자" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="RESACCDAT" 		name="환매회계일자" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="RESACCVNO" 		name="환매전표번호" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#83d7f4 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +

		'<C>id="DISSELCNC_NM"	name="채권매각사" 		width="100" align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="CLDSELFDT" 		name="매각일" 			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="CLDSELAMT" 		name="매각대금"			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="CLDSELDID_NM"	name="매각처리자" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="SELACCDAT" 		name="매각회계일자" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="SELACCVNO" 		name="매각전표번호" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#83d7f4 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		
		'<C>id="CLDCLOKND_NM" 	name="종결사유" 			width="100" align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="CLDCLODAT" 		name="종결처리일" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="CLDCLOLAM" 		name="대손처리금액"		width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="CLDCLODID_NM"	name="종결처리자" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="CLOACCDAT" 		name="종결회계일자" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="CLOACCVNO" 		name="종결전표번호" 		width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#83d7f4 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +

		'<C>id="LOSWONAMT" 		name="최초원금" 			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="LOSLOCAMT" 		name="최초법비용"			width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		'<C>id="LOSWONIJA" 		name="최초미수이자"		width="100" align="right" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} dec=0, sumtext=@sum </C> ' +
		
		'<C>id="SIHENDDAS" 		name="최초시효완성일"		width="110" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="SIHENDDAT" 		name="시효완성일"			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="SIHSTPDAT" 		name="시효중단일"			width="100" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")} Mask="XXXX/XX/XX" </C> ' +
		'<C>id="NPLDTLCDE_NM"	name="NPL상세코드" 		width="150" align="left" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'<C>id="RGTFLDDTM" 		name="등록일시"			width="150" align="center" 	HeadFontStyle=bold HeadBgColor=#e1e0e0 HeadColor=#606060 BgColor={decode(CurRow-(CurRow/2)\*2,0,"#f4f0eb",1,"#ffffff")}</C> ' +
		'';

	grdSheet01.DataID = "dataSet01";
	grdSheet01.ViewSummary 	= 1;
	grdSheet01.OutLineColor("all") = "#808080";

	// 이전 달 마지막일자 구하기
	<%-- var MonFDay = "<%=Tool.getDate()%>".substring(0,6);
	MonFDay = jsAddDays(MonFDay.concat("01"),-1);

	document.all.SEL_TO.value = addDateFormatStr(MonFDay); --%>

	document.all.SEL_TO.value = addDateFormatStr("<%=Tool.getDate()%>");
}
</script>

<!-- ***************************************************************************
** JavaScript Block : Page별(업무)에 따른 함수구현 
***************************************************************************** -->
<script language="javascript">

<!-- 프로그램현황 SELECT -->
function queryData()
{
	condSet.ClearAll();

    var	condHeader	= "SEARCH_KUBUN:STRING(9),KEYWORD:STRING(30),CLDOWNKND:STRING(9),CLDOWPKND:STRING(9),SIGPROSTS:STRING(9),"
        			+ "CLDISDEBS:STRING(20),CLDOCRKND:STRING(9),CLDISDCYN:STRING(1),MGTMINBRH:STRING(9),MGTFLDDPT:STRING(9),"
					+ "MGTPSNDID:STRING(20),DATE_KUBUN:STRING(9),DATE_FROM:STRING(8),DATE_TO:STRING(8),SEL_TO:STRING(8),NPLDTLCDE:STRING(9)";

    condSet.SetDataHeader(condHeader);
    condSet.AddRow();

    condSet.NameValue(1, "SEARCH_KUBUN") = document.all.SEARCH_KUBUN.value;		// [SEARCH_KUBUN 검색조건] EXCFLDNBR : 계약번호, CUSTMRCDE : 고객번호, NPLBMECDE : 보증인 거래처코드, NPLBMENAM : 보증인명
    condSet.NameValue(1, "KEYWORD")    = document.all.KEYWORD.value;			// 검색어
    condSet.NameValue(1, "CLDOWNKND")  = document.all.CLDOWNKND.value;			// 채권구분 [ZA02]
    condSet.NameValue(1, "CLDOWPKND")  = document.all.CLDOWPKND.value;			// 현재채권구분 [ZA02]
    condSet.NameValue(1, "SIGPROSTS")  = document.all.SIGPROSTS.value;			// 결재상태 [SY31]
    condSet.NameValue(1, "CLDISDEBS")  = document.all.CLDISDEBS.value;			// 채무상태 [ZA01]
    condSet.NameValue(1, "CLDOCRKND")  = document.all.CLDOCRKND.value;			// 취득분류 [ZA06]
    condSet.NameValue(1, "CLDISDCYN")  = document.all.CLDISDCYN.value;			// 채권종결여부 Y/N
    condSet.NameValue(1, "MGTMINBRH")  = document.all.MGTMINBRH.value;			// 관리본지점[CM03]
    condSet.NameValue(1, "MGTFLDDPT")  = document.all.MGTFLDDPT.value;			// 부서[CM04]
    condSet.NameValue(1, "MGTPSNDID")  = document.all.MGTPSNDID.value;			// 담당자
    condSet.NameValue(1, "DATE_KUBUN") = document.all.DATE_KUBUN.value;			// 일자구분
    condSet.NameValue(1, "DATE_FROM")  = jsGetValue(document.all.DATE_FROM);	// 일자From
    condSet.NameValue(1, "DATE_TO")    = jsGetValue(document.all.DATE_TO);		// 일자To
    condSet.NameValue(1, "SEL_TO")     = jsGetValue(document.all.SEL_TO);		// 조회기준일
    condSet.NameValue(1, "NPLDTLCDE")  = document.all.NPLDTLCDE.value;			// NPL상세코드[ZA90]

    trSet01.Action	    = UI_HELPER_SYSM;
    trSet01.KeyValue    = "JSP(I:DS01=condSet,O:DS02=dataSet01)";
    trSet01.Parameters	= "ejbName=PROCEDUREEJB,methodName=selectDataSetByDataSet,spName=ZA0030VX_LIST_NPLBOOMA_FN";
    trSet01.Post();
}

// 부실채권 등록
function ins_NPLBOOMA()
{
	document.formSend.action = "/za/ZA0030_IX.jsp";

	// 암호화처리 submit
	CheckSendForm(formSend, sendForm);
}

// 부실채권 삭제
function del_NPLBOOMA()
{
	// 호출 프로그램 정의 
	var url 	= "/za/ZA0030_POP3.jsp";
	// 보낼 파라메타 정의 
	var value 	= '';
	// openwindows명칭 정의 
	var name	= 'WinOpenZA0030_POP3';
	// open창 size정의
	var size	= "width=1300,height=750,left=100,top=200";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

// 결재버튼
function pop_approve()
{
	// 호출 프로그램 정의 
	var url 	= "/za/ZA0030_POP1.jsp";
	// 보낼 파라메타 정의 
	var value 	= 'PRGFLDCDE='  + dataSet01.NameValue(dataSet01.rowposition,'PRGFLDCDE') 
	            + '&PRGFLDNAM=' + URLEncode(dataSet01.NameValue(dataSet01.rowposition,'PRGFLDNAM'))
	            ;
	// openwindows명칭 정의 
	var name	= 'WinOpenZA0030_POP1';
	// open창 size정의
	var size	= "width=1300,height=750,left=100,top=200";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

// 가상계좌관리 버튼
function ins_virtualAcc()
{
	// 호출 프로그램 정의 
	var url 	= "/za/ZA0030_POP4.jsp";
	// 보낼 파라메타 정의 
	var value 	= '';
	// openwindows명칭 정의 
	var name	= 'WinOpenZA0030_POP4';
	// open창 size정의
	var size	= "width=1550,height=750,left=100,top=200";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

// 화해등록 버튼
function fn_goZA0050_IX()
{
   //호출프로그램 정의
   var url    = "/za/ZA0050_IX.jsp";
   //보낼파라메타 정의
   var value    = "";
   //openwindows명칭 정의
   var name   = "WinOpenZA0050_IX";
   //open창 포지션 정의
   var size     = "width=1500,height=800,left=100,top=50,scrollbars=yes";    // open창 포지션정의

   // 암호화 모듈 사용 WinOpen
   EncLink(url,value,name,size);
}

//화해삭제 버튼
function fn_goZA0050_POP2()
{
	// 호출 프로그램 정의 
	var url 	= "/za/ZA0050_POP2.jsp";
	// 보낼 파라메타 정의 
	var value 	= '';
	// openwindows명칭 정의 
	var name	= 'WinOpenZA0050_POP2';
	// open창 size정의
	var size	= "width=1300,height=750,left=100,top=200";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
	
}

// 부실채권이관 버튼
function fn_goZA0060_IX()
{
   //호출프로그램 정의
   var url    = "/za/ZA0060_IX.jsp";
   //보낼파라메타 정의
   var value    = "";
   //openwindows명칭 정의
   var name   = "WinOpenZA0060_IX";
   //open창 포지션 정의
   var size     = "width=1500,height=520,left=100,top=50,scrollbars=yes";    // open창 포지션정의

   // 암호화 모듈 사용 WinOpen
   EncLink(url,value,name,size);
}

//해지이관취소 화면으로 이동
function fn_goZA0060_POP()
{
   // 호출 프로그램 정의 
   var url    = "/za/ZA0060_POP.jsp";
   // 보낼 파라메타 정의 
   var value    = '';
   // openwindows명칭 정의 
   var name   = 'WinOpenZA0060_POP';
   // open창 size정의
   var size   = "width=1200,height=500,left=200,top=150";

   // 암호화 모듈 사용 WinOpen
   EncLink(url,value,name,size);
}

// 부실채권원장 상세화면으로 이동
function fn_goZA0030_UX(row)
{
	document.formSend.sEXCFLDNBR.value = dataSet01.NameValue(row,"EXCFLDNBR");	// 계약번호
	
	document.formSend.action = "/za/ZA0030_UX.jsp";
	
	// 암호화처리 submit
	CheckSendForm(formSend, sendForm);
}

// 엑셀업로드 버튼
function EXCEL_UPLOAD_POP()
{	
	// 호출 프로그램 정의 
	var url 	= "/za/ZA0030_POP2.jsp";
	// 보낼 파라메타 정의 
	var value 	= '';
	// openwindows명칭 정의 
	var name	= 'WinOpenZA0030_POP2';
	// open창 size정의
	var size	= "width=1200,height=600,left=300,top=200";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

// 매각/환매 팝업
function pop_sellRepur()
{
	// 호출 프로그램 정의 
	var url 	= "/za/ZA0030_POP7.jsp";
	// 보낼 파라메타 정의 
	var value 	= '';
	// openwindows명칭 정의 
	var name	= 'WinOpenZA0030_POP7';
	// open창 size정의
	var size	= "width=1300,height=800,left=300,top=200";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

// 매각/환매 취소 팝업
function del_sellRepur()
{
	// 호출 프로그램 정의 
	var url 	= "/za/ZA0030_POP9.jsp";
	// 보낼 파라메타 정의 
	var value 	= '';
	// openwindows명칭 정의 
	var name	= 'WinOpenZA0030_POP9';
	// open창 size정의
	var size	= "width=1300,height=800,left=300,top=200";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

// 담당자/NPL상세코드 일괄변경
function chg_MGTPSNDID()
{
	// 호출 프로그램 정의 
	var url 	= "/za/ZA0030_POP6.jsp";
	// 보낼 파라메타 정의 
	var value 	= '';
	// openwindows명칭 정의 
	var name	= 'WinOpenZA0030_POP6';
	// open창 size정의
	var size	= "width=1200,height=750,left=300,top=200";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

//담당자 선택 팝업
function f_UserId_Search()
{
	//호출프로그램 정의
	var url 	= "/pp/PP0010_POP.jsp";
	//보낼파라메타 정의
	var value 	= 'USEKUBUN=CMBASUSR';
	//openwindows명칭 정의
	var name	= 'WinOpen_PP0010_POP_CALL';
	//open창 포지션 정의
	var size	= "width=700,height=400,left=100,top=50";

	//암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

// 담당자 선택 data
function setAddCMBASUSR()
{
	document.all.MGTPSNDID.value	= setCMBASUSR.NameValue(1,'USRFLDIDN'); // 담당자ID
	document.all.MGTPSNDID_NM.value	= setCMBASUSR.NameValue(1,'NAMFLDNAM'); // 담당자명
}

// 담당자 FOCUS_OUT
function keyPressUserId()
{
	if (document.all.MGTPSNDID.value == '')
	{
		document.all.MGTPSNDID_NM.value = '';
		return;
	}
	else
		chk_UserId(document.all.MGTPSNDID.value);
}

// 담당자 FOCUS_OUT chk_UserId 정당성 리턴
function getCMBASUSR()
{
	if (setCMBASUSR.CountRow == 0 )
	{
		// 입력된 등록자ID 데이타가 존재하지 않습니다.
		alert_popup('COMM','0382');

		document.all.MGTPSNDID.value = '';
		document.all.MGTPSNDID_NM.value = '';

		document.all.MGTPSNDID.focus();
	}
	else
		setAddCMBASUSR();
}

<!-- 전표조회 팝업호출 -->
function fn_popPP0063(row, colid, colidDate)
{
	var form = document.all;
	
	var vACCFLDGRP = '';	// 회계그룹
	var vACCFLDDAT = '';	// 회계일자
	var vJNPFLDNBR = 0;		// 전표번호

	vACCFLDDAT = colidDate;							// 회계일자
	vJNPFLDNBR = dataSet01.NameValue(row, colid);	// 전표번호

	// 회계그룹, 회계일자, 전표번호 중 하나의 값이라도 없으면 조회불가
	if ( vACCFLDDAT == '' || vJNPFLDNBR == '' )
		return;

	// 호출 프로그램 정의 
	var url 	= "/pp/PP0063_POP.jsp";
	// 보낼 파라메타 정의 [회계그룹, 회계일자, 전표번호]
	var value 	= "ACCFLDGRP="  + "<%=sessionAccGroup%>"
				+ "&ACCFLDDAT=" + vACCFLDDAT
				+ "&JNPFLDNBR=" + vJNPFLDNBR ;
				
	// openwindows명칭 정의 
	var name	= "WinOpenPP0063_POP";
	// open창 size정의
	var size = "width=1200,height=780,left=100,top=150";

	// 암호화 모듈 사용 WinOpen
	EncLink(url,value,name,size);
}

<!-- 엔터조회 -->
function keyPress() 
{
	if (event.keyCode == 13)
	{
   		queryData();
	}
}

<!-- 엑셀 파일 -->
function f_Excel()	
{
	f_onExcel(dataSet01, grdSheet01, '부실채권원장');
}

</script>

<!-- ***************************************************************************
** DataSet, trSet Event Handle 구간
***************************************************************************** -->
<!--	DataSet events block	-->
<script language="javascript" for="dataSet01" event="OnDataError(row, colid)">
	printMessage("error", this.ErrorCode, this.ErrorMsg);
</script>

<script language="javascript" for="dataSet01" event="OnLoadStarted()">
	printMessage("loading");
</script>

<!--	Transaction events block	-->
<script language="javascript" for="trSet01" event="OnFail()">
	printMessage("error", this.ErrorCode, this.ErrorMsg);
</script>
<script language="javascript" for="trSet01" event="OnSuccess()">
	printMessage("queried", dataSet01.CountRow);
</script>

<!--	Transaction events block	-->
<script language="javascript" for="trSet02" event="OnFail()">
	printMessage("error", this.ErrorCode, this.ErrorMsg);
</script>
<script language="javascript" for="trSet02" event="OnSuccess()">
	printMessage("queried", dataSet01.CountRow);
	alert_popup('COMM','0001');	// 정상적으로 처리되었습니다.
</script>


<!-- 데이타 정렬 -->
<script language="javascript" for="grdSheet01" event="OnClick(row, colid)">
    if (dataSet01.countrow == 0)
    {
        return;
    }

	sortGridOnClickHeader(dataSet01, row, colid);
</script>

<!-- 그리드 더블클릭 -->
<script language="javascript" for="grdSheet01" event="OnDblClick(row, colid)">

	if (dataSet01.countrow == 0) return;

	if (colid == 'CUSTMRCDE')	// 고객번호 더블클릭시 고객상세 팝업
	{
		if (dataSet01.NameString(dataSet01.RowPosition, "EXCFLDNBR") != '')
		{
			// 호출 프로그램 정의 
			var url 	= "/za/ZA0020_UX.jsp";
			// 보낼 파라메타 정의 
			var value 	= 'pCustCode=' + dataSet01.NameValue(row, "CUSTMRCDE")
						+'&pTaskCode=update'
						+'&ppopup=Y'
						;
			// openwindows명칭 정의 
			var name	= 'WinOpenZA0020_UX';
			// open창 size정의
			var size	= "width=1750,height=850,left=100,top=100,scrollbars=yes";

			// 암호화 모듈 사용 WinOpen
			EncLink(url,value,name,size);
		}
	}
	else if (colid == "REGACCVNO" || colid == "CLOACCVNO")
	{
		var colidDate;
		
		if (colid == "REGACCVNO")
			colidDate = dataSet01.NameValue(row, "REGACCDAT");	// 등록회계일자
		else if (colid == "CLOACCVNO")
			colidDate = dataSet01.NameValue(row, "CLOACCDAT");	// 종결회계일자
		else if (colid == "RESACCVNO")
			colidDate = dataSet01.NameValue(row, "RESACCDAT");	// 환매회계일자
		else if (colid == "SELACCVNO")
			colidDate = dataSet01.NameValue(row, "SELACCDAT");	// 매각회계일자
			
		// 전표조회 팝업
		fn_popPP0063(row, colid, colidDate);
	}
	else
	{
		fn_goZA0030_UX(row);	//상세화면으로 이동
	}
	
</script>
<!-- ************************************************************************ -->
</head>
<body topmargin="0" leftmargin="0" onload="initWindow();clickMove('<%=navi.print_title()%>');">
<!-- html 암호화 시작 -->
<%@ include file="/autocomm/inc/initech1.inc"%>
<%@ include file="/autocomm/inc/lst1.inc"%>

<!-- 암호화 시킨 것을 암호화 변수에 넣기 위한 변수 선언 -->
<%@ include file="/autocomm/inc/initech.inc"%>
<center>
<%=navi.print()%>		<!-- Navigation Print -->

<!-- ********************************************************************************************
** HTML 화면구현 구간
** Html Guide 			: 들여쓰기는 Tab 1(space 4)로 처리함 
** Element별 필수기재속성 	: *권한(secType)
**							 - 등록(btn_insert), 수정(btn_update), 삭제(btn_delete)
**							 - 조회(btn_search), 승인(btn_appro),  엑셀(btn_excel)
**							 - 심사승인(btn_simsa),자금입지급(btn_fund),전표승인(btn_slip)
**						   * 부서별처리범위 (secType)
**							 - 관리지점(cmb_branch), 부서코드(cmb_dept)
**                         *데이터타입(dataType)
**							 - date, date1, number, integer, float, zipCode, time,
**							   jumin, saup, saupjumin, memberCard, corporate, 
**							   datetime, license, licenseFull, phone, timestamp,
**							   hyphen1
**                         *Display명기재 : notNull(필수항목에 사용)과 함께 쓰임 
**		ex) <input type="text" dataType="date" maxlength="8" dispName="기준일" notnull>
**			<input type="button" value="저장" secType="btn_insert">
			<td><script>TaskButton("품의등록","btn_insert","save.html");</script></td>
************************************************************************************************* -->
<form name="formSend" action="post">
<input type="hidden" name="sEXCFLDNBR"><!-- 계약번호 -->
</form>

<!-- ST : Search Form -->
<form name="searchForm" onsubmit = "return false">
	<table class="intableT">
		<tr>
			<td width="7%" class="intitleT">검색조건</td>
			<td width="15%">
				<select name="SEARCH_KUBUN" style="width:40%;" onkeypress="javascript:keyPress();">
         			<option value="" selected>전체</option>
         			<option value="EXCFLDNBR">계약번호</option>
         			<option value="CUSTMRCDE">고객번호</option>
         			<option value="NPLBMECDE">보증인코드</option>
         			<option value="NPLBMENAM">보증인명</option>
         			<option value="CLDPURCNO">매입사계약번호</option>
         			<option value="DISPURCNM">매입처명</option>
         			<option value="CUSTDEKEY">채무자키</option>
				</select>
				<input type="text" name="KEYWORD" style="width:50%;" maxlength="40" onkeypress="javascript:keyPress();">
			</td>		
			<td width="7%" class="intitleT">채권구분</td>
			<td width="10%">
				<select name="CLDOWNKND" style="width:80%;">
         			<option value="" selected>전체</option>
					<%=ZA02.printOption() %>
				</select>
			</td>
			<td width="7%" class="intitleT">현재채권구분</td>
			<td width="10%">
				<select name="CLDOWPKND" style="width:80%;">
         			<option value="" selected>전체</option>
					<%=ZA02.printOption() %>
				</select>
			</td>
			<td width="7%" class="intitleT">결재상태</td>
			<td width="10%">
				<select name="SIGPROSTS" style="width:80%;">
	       			<option value="" selected>전체</option>
	       			<%=SY31.printOption() %>
				</select>
			</td>
			<td width="7%" class="intitleT">채무상태</td>
			<td width="10%">
				<select name="CLDISDEBS" style="width:80%;">
         			<option value="" selected>전체</option>
         			<option value="정상">정상</option>
         			<option value="화해정상">화해정상</option>
         			<option value="개회정상">개회정상</option>
         			<option value="신복정상">신복정상</option>
         			<option value="화해연체">화해연체</option>
         			<option value="개회연체">개회연체</option>
         			<option value="신복연체">신복연체</option>
         			<option value="종결">종결</option>
				</select>
			</td>
			<td align="right">
				<input type="button" secType="btn_search"  class="input60"     value="조회" onClick="queryData();">
				<input type="button" secType="btn_excel"   class="input60_exl" value="엑셀" onClick="f_Excel();" >
			</td>
		</tr>
		<tr>
			<td class="intitleT">취득분류</td>
			<td>
				<select name="CLDOCRKND" style="width:60%;">
	       			<option value="" selected>전체</option>
	       			<%=ZA06.printOption() %>
				</select>
			</td>
			<td class="intitleT">종결Y/N</td>
			<td>
				<select name="CLDISDCYN" style="width:80%;">
	       			<option value="" selected>전체</option>
	       			<option value="Y">Y</option>
	       			<option value="N">N</option>
				</select>
			</td>
			<td class="intitleT">관리본지점</td>
			<td>
				<select name="MGTMINBRH" style="width:80%;">
	       			<option value="" selected>전체</option>
	       			<%=CM03.printOption() %>
				</select>
			</td>
			<td class="intitleT">부서</td>
			<td>
				<select name="MGTFLDDPT" style="width:80%;">
	       			<option value="" selected>전체</option>
	       			<%=CM04.printOption() %>
				</select>
			</td>
			<td class="intitleT">담당자</td>
			<td colspan="2">
				<input type="text" name="MGTPSNDID" maxlength="9" style="width:65;" onfocusout="javascript:keyPressUserId();">
				<a onclick="javascript:f_UserId_Search();" onFocus="this.blur()">
				<img src="/img/main/search.gif" align="absmiddle"></a>
				<input type="text" name="MGTPSNDID_NM" class="boxnoline_l" style="width:20%;" disabled>
			</td>
		</tr>
		<tr>
			<td class="intitleT">조회기준일</td>
			<td>
				<input datatype="date" maxlength="8" name="SEL_TO" style="width:40%;" class="center" onkeypress="javascript:keyPress();">
				<img src="/img/main/bu_date.gif" onClick="show_calendar('searchForm.SEL_TO','','')" class="bt" align=absmiddle alt="달력">
			</td>
			<td class="intitleT">일자구분</td>
			<td colspan="3">
				<select name="DATE_KUBUN" style="width:30%;" onkeypress="javascript:keyPress();">
         			<option value="" selected>선택</option>
         			<option value="RGTFLDDTM">등록일자</option>
         			<option value="CLDPURBSD">매입일자</option>
         			<option value="TRSACTDAT">이관일자</option>
         			<option value="CLDRESDAT">환매일자</option>
         			<option value="RESACCDAT">환매회계일자</option>
         			<option value="CLDSELFDT">매각일자</option>
         			<option value="SELACCDAT">매각회계일자</option>
         			<option value="SIHENDDAS">최초시효완성일</option>
         			<option value="SIHENDDAT">시효완성일</option>
         			<option value="SIHSTPDAT">시효중단일</option>
				</select>
				<input datatype="date" maxlength="8" name="DATE_FROM" style="width:20%;" class="center" onkeypress="javascript:keyPress();">
				<img src="/img/main/bu_date.gif" onClick="show_calendar('searchForm.DATE_FROM','','')" class="bt" align=absmiddle alt="달력"> ~
				<input datatype="date" maxlength="8" name="DATE_TO" style="width:20%;" class="center" onkeypress="javascript:keyPress();">
				<img src="/img/main/bu_date.gif" onClick="show_calendar('searchForm.DATE_TO','','')" class="bt" align=absmiddle alt="달력">
			</td>
			<td class="intitleT">NPL상세코드</td>
			<td>
				<select name="NPLDTLCDE" style="width:80%;">
				<option value="">선택</option>
				<%=ZA90.printOption() %>
				</select>
			</td>
			<td class="intitleT"></td>
			<td colspan="2"></td>
		</tr>
	</table>
</form>
<!-- ED : Search Form -->

<!-- ST : Sub Title & Img SayButton -->
<form name="buttonForm">
	<table cellspacing="1" cellpadding="1" class="intableB">
		<tr>
			<td class="subtitle">
				<p class="WinM_title" style="display: inline;">부실채권 원장내역</p>
				<p style="display: inline;">&nbsp;&nbsp;<font color='red'>* 그리드 더블클릭시 상세화면으로 이동합니다.  (고객번호)더블클릭시 고객상세 팝업을 호출합니다.</font></p>
			</td>
			<td align=right>
		    	<input type="button" secType="btn_insert" value="가상계좌관리"		class="input100" onClick="ins_virtualAcc();">&nbsp;&nbsp;&nbsp;&nbsp;
		    	<input type="button" secType="btn_insert" value="부실채권이관" 		class="input100" onClick="fn_goZA0060_IX();">
		    	<input type="button" secType="btn_insert" value="해지이관취소" 		class="input100" onClick="fn_goZA0060_POP();">&nbsp;&nbsp;&nbsp;&nbsp;
		    	
		    	<input type="button" secType="btn_update" value="담당자/NPL상세코드"  class="input120" onClick="chg_MGTPSNDID();">
		    	<input type="button" secType="btn_insert" value="엑셀업로드" 			class="input80"  onClick="EXCEL_UPLOAD_POP();">
		    	<input type="button" secType="btn_insert" value="부실채권등록"		class="input100" onClick="ins_NPLBOOMA();">
		    	<input type="button" secType="btn_insert" value="결재/취소"			class="input80"  onClick="pop_approve();">
		    	<input type="button" secType="btn_delete" value="부실채권삭제"		class="input100" onClick="del_NPLBOOMA();">
		    	<input type="button" secType="btn_update" value="매각/환매"  		class="input80"	 onClick="pop_sellRepur();">
		    	<input type="button" secType="btn_update" value="매각/환매취소"  		class="input100" onClick="del_sellRepur();">
			</td>
		</tr>
	</table>
</form>
<!-- ED : Sub Title & Img SayButton -->

<!-- ST : Grid -->
<table class="intableB" cellspacing=0 width="100%" height="80%">
	<tr>
		<td>
			<jsp:include flush="true" page="/autocomm/inc/base/grid.jsp?id=grdSheet01"/>
		</td>
	</tr>
</table>
<!-- ED : Grid -->

<%@ include file="/autocomm/inc/lst2.inc"%>
</body>
</html>