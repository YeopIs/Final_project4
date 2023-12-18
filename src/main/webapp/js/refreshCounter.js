var refreshData = JSON.parse(localStorage.getItem('refreshData')) || { count: 0, lastRefreshTime: new Date().getTime() };

function trackRefresh() {
    var currentTime = new Date().getTime();
    var timeLimit = 5000;

    if (currentTime - refreshData.lastRefreshTime < timeLimit) {
        refreshData.count++;
    } else {
        refreshData.count = 1;
        refreshData.lastRefreshTime = currentTime;
    }

    if (refreshData.count >= 3) {
        window.location.href = '/refresh/captcha';
    }

    localStorage.setItem('refreshData', JSON.stringify(refreshData));
}

function detectUserInteraction() {
    refreshData.count = 0;
    localStorage.setItem('refreshData', JSON.stringify(refreshData));
}

document.addEventListener('click', detectUserInteraction);

window.onload = trackRefresh;