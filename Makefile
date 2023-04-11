.DEFAULT_GOAL:=help

##@ Help
.PHONY: help
help: ## Display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Verify Helm Charts
.PHONY: verify-charts
verify-charts: ## Lint all helm charts for errors
	@for d in charts/*/; do \
    	helm lint $$d; \
	done

##@ Generate Helm Charts
.PHONY: generate-charts
generate-charts: ## Generate and pack all helm charts
	@rm -rf _chart/
	@for d in charts/*/; do \
		echo "Packing chart: $$d"; \
    	helm package $$d/; \
	done
	@mkdir _chart/
	@mv *.tgz _chart/