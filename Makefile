verify-charts:
	@for d in charts/*/; do \
    	helm lint $$d; \
	done

generate-charts:
	@rm -rf _chart/
	@for d in charts/*/; do \
		echo "Packing chart: $$d"; \
    	helm package $$d/; \
		helm repo index --url https://dmahmalat.github.io/charts . --merge index.yaml; \
	done
	@mkdir _chart/
	@mv *.tgz _chart/
	@mv index.yaml _chart/