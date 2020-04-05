docker build -t vaibhavgulhane/multi-client:latest -t vaibhavgulhane/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vaibhavgulhane/multi-server:latest -t vaibhavgulhane/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vaibhavgulhane/multi-worker:latest -t vaibhavgulhane/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vaibhavgulhane/multi-client:latest
docker push vaibhavgulhane/multi-server:latest
docker push vaibhavgulhane/multi-worker:latest

docker push vaibhavgulhane/multi-client:$SHA
docker push vaibhavgulhane/multi-server:$SHA
docker push vaibhavgulhane/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vaibhavgulhane/multi-server:$SHA
kubectl set image deployments/client-deployment client=vaibhavgulhane/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vaibhavgulhane/multi-worker:$SHA