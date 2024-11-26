#!/bin/bash

RTSP_URL="rtsp://username:password@camera-ip_address:port" #請更換這邊的rstp串流網址

declare -A duration_options
duration_options=( ["1"]="3600"
                   ["2"]="86400"
                   ["3"]="604800"
                   ["4"]="2592000"
                  )

declare -A speed_options
speed_options=( ["1"]="0.00002778"
                ["2"]="0.00001157"
                ["3"]="0.000099"
                ["4"]="0.004"
               )

echo "請選擇錄製時間："
echo "1) 1 小時"
echo "2) 1 天"
echo "3) 1 週"
echo "4) 1 個月"
read -p "輸入選擇的編號 (1-4): " choice

if [[ ! ${duration_options[$choice]} ]]; then
    echo "無效的選擇。請輸入 1 到 4 之間的數字。"
    exit 1
fi

RECORD_DURATION=${duration_options[$choice]}
TIMELAPSE_SPEED=${speed_options[$choice]}

mkdir -p ~/tapo_recordings
cd ~/tapo_recordings

echo "開始錄製..."
ffmpeg -i $RTSP_URL -c:v copy -c:a aac -b:a 128k -t $RECORD_DURATION "output.mp4"

if [ $? -ne 0 ]; then
    echo "錄製失敗，請檢查 RTSP URL 和網路連接。"
    exit 1
fi

echo "創建縮時影片..."
ffmpeg -i "output.mp4" -filter:v "setpts=$TIMELAPSE_SPEED*PTS" "output_timelapse.mp4"

if [ $? -ne 0 ]; then
    echo "縮時影片創建失敗。"
    exit 1
fi

echo "上傳影片到 Google Drive..."
/root/./gdrive files upload "output_timelapse.mp4"

echo "清理臨時文件..."
rm "output.mp4"

echo "完成！"
