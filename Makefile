
base/debug:
	docker build -f .gitpod.Dockerfile -t gitpod-dockerfile-test .
	docker run -it gitpod-dockerfile-test bash

infra/apply:
	@terraform -chdir=infra apply

infra/plan:
	@terraform -chdir=infra plan
