docker build -t shreenibrahim/multi-client:latest -t shreenibrahim/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shreenibrahim/multi-server:latest -t shreenibrahim/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t shreenibrahim/multi-worker:latest -t shreenibrahim/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shreenibrahim/multi-client:latest
docker push shreenibrahim/multi-server:latest
docker push shreenibrahim/multi-worker:latest


docker push shreenibrahim/multi-client:$SHA
docker push shreenibrahim/multi-server:$SHA
docker push shreenibrahim/multi-worker:$SHA


kubectl apply -f k8s


kubectl set image deployments/server-deployment server=shreenibrahim/multi-server:$SHA
kubectl set image deployments/client-deployment client=shreenibrahim/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shreenibrahim/multi-worker:$SHA

