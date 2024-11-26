# 為什麼要做這個
原因是我架設在某個地方的監視器，因為一些個人因素，所以監視器就意外的被拿下來，只能讓我帶回家用  
看他放在我的桌上，不好好利用一下好像就不是搞機精神ㄌ  
所以我將它放在了窗外，並且想拿它來錄製縮時攝影  
不過Tapo本身沒有錄製縮時的功能，這讓我非常苦惱  
只能夠自己想個方法，想辦法讓錄製的一般影片變成縮時  
還有Tapo有給rstp的影像，這讓一切都變得了更有可玩性  

# 前置作業
1. 獲取Tapo rstp的網址影像，[參考這邊](https://www.tp-link.com/tw/support/faq/2680/)
2. 你需要有一台連著網路的Debian電腦
3. 把你的監視器放在固定位置，準備來開始錄製縮時攝影

# 實際步驟
連進去你Debian主機後，首先要先來安裝我們這次的套件
我們會用ffmpeg來錄製，然後用gdrive來自動上傳雲端
   ```bash
   sudo apt update
   sudo apt install ffmpeg -y
   wget https://github.com/glotlabs/gdrive/releases/download/3.9.1/gdrive_linux-x64.tar.gz
   tar xvf gdrive_linux-x64.tar.gz
   ```
安裝完之後，你需要參考gdrive官方的wiki，來讓你的gdrive和你的Google Drive連接，[參考這邊](https://github.com/glotlabs/gdrive/blob/main/docs/create_google_api_credentials.md)
接著輸入下列指令，來獲取這次的腳本
   ```bash
   git clone https://github.com/Zhuyuan0907/Tapo-RSTP-Record
   ```
進入目錄
   ```bash
   cd Tapo-RSTP-Record/
   ```
編輯裡面的record.sh，也就是這次的錄製縮時的腳本

   ```bash
   nano record.sh
   ```
記得將裡面的 RTSP_URL= 替換成自己Tapo的rstp URL
Curl + X，按Y，按下Enter 退出編輯模式

然後要幫這個腳本加上權限，不然你沒有辦法執行它
   ```bash
   chmod +x record.sh
   ```
最後，就可以來執行這個腳本
我會放在screen下跑，確保我離開SSH之後還在運行
   ```bash
   screen
   ./record.sh
   ```

# 運行成果
![image](https://github.com/user-attachments/assets/36e9d983-3ae6-4c83-b3e8-c87b3e426195)
