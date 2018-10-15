  docker build -t filip505/multi-client:latest -t filip505/multi-client:$SHA ./client
  docker build -t filip505/multi-server:latest -t filip505/multi-server:$SHA ./server
  docker build -t filip505/multi-worker:latest -t filip505/multi-worker:$SHA ./worker

  docker push filip505/multi-client
  docker push filip505/multi-server
  docker push filip505/multi-worker

  docker push filip505/multi-client:$SHA
  docker push filip505/multi-server:$SHA
  docker push filip505/multi-worker:$SHA

  kubectl apply -f k8s
  kubectl set image deployments/server-deployment server=filip505/multi-server:$SHA
  kubectl set image deployments/client-deployemnt client=filip505/multi-client:$SHA
  kubectl set image deployments/worker-deployemnt worker=filip505/multi-worker:$SHA