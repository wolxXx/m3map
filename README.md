# m3map

mario 3 nes version - all cards solutions :) 


docker build -t wolxxx/m3map:1.2 .

docker stop m3map

docker rm m3map

docker run -it --restart=always --name m3map -d -p 127.0.0.1:8098:80 wolxxx/m3map:1.2