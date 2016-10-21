function tunnlrtest
	ssh -v -nNt -g -R :13352:0.0.0.0:1880 tunnlr4318@ssh1.tunnlr.com
end
