docker build -t ravisinceilogin/multi-client:latest -t ravisinceilogin/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t ravisinceilogin/multi-server:latest -t ravisinceilogin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ravisinceilogin/multi-worker:latest -t ravisinceilogin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ravisinceilogin/multi-client:latest
docker push ravisinceilogin/multi-server:latest
docker push ravisinceilogin/multi-worker:latest

docker push ravisinceilogin/multi-client:$SHA
docker push ravisinceilogin/multi-server:$SHA
docker push ravisinceilogin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ravisinceilogin/multi-server:$SHA
kubectl set image deployments/client-deployment client=ravisinceilogin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ravisinceilogin/multi-worker:$SHA