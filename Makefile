.PHONY: genhtml
genhtml: genhtml ## Generate HTML coverage report from lcov data
	@which genhtml > /dev/null || (echo "genhtml not installed, installing..." && brew install lcov)
	genhtml coverage/lcov.info -o coverage/html
