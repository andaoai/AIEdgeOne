# 进入 /data 目录
cd /data

# 创建 actions-runner 文件夹并进入
mkdir -p actions-runner && cd actions-runner

# 下载最新的 runner 包
curl -o actions-runner-linux-arm64-2.323.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-linux-arm64-2.323.0.tar.gz

# 可选：验证 hash
echo "9cb778fffd4c6d8bd74bc4110df7cb8c0122eb62fda30b389318b265d3ade538  actions-runner-linux-arm64-2.323.0.tar.gz" | shasum -a 256 -c

# 解压安装包
tar xzf ./actions-runner-linux-arm64-2.323.0.tar.gz

# 创建 runner 并开始配置过程
./config.sh --url https://github.com/andaoai/AIEdgeOne --token AND56STF473IT5A4N66BN43H4PEPU

# 创建一个 systemd 服务文件
cat <<EOF | sudo tee /etc/systemd/system/github-runner.service
[Unit]
Description=GitHub Actions Runner
After=network.target

[Service]
User=your_username
WorkingDirectory=/data/actions-runner
ExecStart=/data/actions-runner/run.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 刷新 systemd 配置
sudo systemctl daemon-reload

# 启用 runner 服务
sudo systemctl enable github-runner.service

# 启动 runner 服务
sudo systemctl start github-runner.service
