/* 테이블 상단 체크박스 클릭 시 전체 선택 */
function allCheck(isChecked) {
    var chs = document.querySelectorAll('input[type="checkbox"]');
    chs.forEach(function(checkbox) {
        checkbox.checked = isChecked;
    });
}

/* 클릭된 체크박스 수 */
var checkCount = function() {
    var chk = document.getElementsByName('chk');
    let cnt = 0;
    for (let i = 0; i < chk.length; i++) {
        if (chk[i].checked) {
            cnt++;
        }
    }
    return cnt;
}

/* 체크박스 체크에 따라서 checkAll 체크 변경 여부 */
window.onload = function() {
    var chk = document.getElementsByName('chk');
    var chkAll = document.getElementById('chkAll');
    
    // 모든 체크박스의 상태에 따라 상단 체크박스 상태 업데이트
    chkAll.onclick = function() {
        allCheck(chkAll.checked);
    };

    for (let i = 0; i < chk.length; i++) {
        chk[i].onclick = function() {
            // 체크박스 수와 전체 체크박스 수 비교
            if (chk.length === checkCount()) {
                chkAll.checked = true;
            } else {
                chkAll.checked = false;
            }
        };
    }
};




