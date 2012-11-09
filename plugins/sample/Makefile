#
# Copyright (C) 2012 by Trend Micro Inc, All rights are reserved. 
#
# Reproduction or transmission in whole or in part, in any form or by 
# any means, electronic, mechanical or otherwise, is prohibited without 
# the prior written permission of the copyright owner.
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
# 
# THIS PLUGIN IS PROVIDED "AS IS". TREND MICRO MAKES NO WARRANTY OR 
# PROMISE ABOUT THE OPERATION OR PERFORMANCE OF THIS PLUGIN NOR DOES 
# IT WARRANT THAT THIS PLUGIN IS ERROR FREE. TO THE FULLEST EXTENT 
# PERMITTED BY LAW, TREND MICRO DISCLAIMS ALL IMPLIED AND STATUTORY 
# WARRANTIES, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF 
# MERCHANTABILITY, NONINFRINGEMENT AND FITNESSFOR A PARTICULAR PURPOSE.
#

PYTHON_OUTPUT = ../output/installation

PLUGIN_FILES = sample.pyc sample.xml

PLUGIN_ZIP = sample.zip

all: build plugin

build:
	python -mcompileall .

plugin: $(PLUGIN_FILES)
	-rm -f $(PLUGIN_ZIP)
	zip -q $(PLUGIN_ZIP) $(PLUGIN_FILES)

install:
	mkdir -p ${PYTHON_OUTPUT}
	cp $(PLUGIN_ZIP) ${PYTHON_OUTPUT}

clean:
	-rm -f $(PLUGIN_ZIP)
	-rm -f *.pyc *.pyo

