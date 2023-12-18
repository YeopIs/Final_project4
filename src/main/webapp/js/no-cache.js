document.addEventListener("DOMContentLoaded", function() {
    // 'no-reload-on-back' 클래스가 있는 페이지에서는 실행하지 않음
    if (!document.body.classList.contains('no-reload-on-back')) {
        if (window.performance && window.performance.navigation.type === window.performance.navigation.TYPE_BACK_FORWARD) {
            location.reload();
            console.log('reload');
        }
    }
});