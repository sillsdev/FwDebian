# Copyright (c) 2016-2017 SIL International
# This software is licensed under the MIT license (http://opensource.org/licenses/MIT)
#
# CMake file for creating database model specific packages

cmake_minimum_required (VERSION 2.8)
project(LfMergeFDO)

option(ADD_PACKAGE_LINK "Add package link" OFF)

# The highest model version number that any version of FW currently uses
set(MAX_DB_VERSION 7000070)

# extract FW database model version
execute_process(
	COMMAND bash -c "grep '<EntireModel' MasterFieldWorksModel.xml | sed -r 's/^.*version=\"([0-9]+)\".*/\\1/'"
	WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/../fw/Src/FDO"
	OUTPUT_VARIABLE DatabaseVersion
	OUTPUT_STRIP_TRAILING_WHITESPACE
)

#define a macro to extract variables from MasterVersionInfo.txt
macro (get_version arg variable)
	execute_process(
		COMMAND bash -c "grep ${arg} MasterVersionInfo.txt | sed -r 's/${arg}=([0-9]+)/\\1/'"
		WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/../fw/Src"
		OUTPUT_VARIABLE ${variable}
		OUTPUT_STRIP_TRAILING_WHITESPACE
		)
endmacro (get_version)

get_version(FWMAJOR FwMajor)
get_version(FWMINOR FwMinor)
get_version(FWREVISION FwRevision)

execute_process(
	COMMAND bash -c "cpp -D__DatabaseVersion__=${DatabaseVersion} -D__MaxDbVersion__=${MAX_DB_VERSION} -P -traditional-cpp ${PROJECT_SOURCE_DIR}/control.in"
	WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/../fw/Src/FDO"
	OUTPUT_FILE "/tmp/control.in"
)

configure_file (
	"/tmp/control.in"
	"${PROJECT_SOURCE_DIR}/control"
	@ONLY
)

configure_file (
	"${PROJECT_SOURCE_DIR}/changelog.in"
	"${PROJECT_SOURCE_DIR}/changelog"
	@ONLY
)

configure_file (
	"${PROJECT_SOURCE_DIR}/lfmerge-fdo-dbversion.install.in"
	"${PROJECT_SOURCE_DIR}/lfmerge-fdo-@DatabaseVersion@.install"
	@ONLY
)

configure_file (
	"${PROJECT_SOURCE_DIR}/lfmerge-fdo.pc.in"
	"${PROJECT_SOURCE_DIR}/lfmerge-fdo-@DatabaseVersion@.pc"
	@ONLY
)

configure_file (
	"${PROJECT_SOURCE_DIR}/lfmerge-fdo.pc.in"
	"${PROJECT_SOURCE_DIR}/lfmerge-fdo.pc"
	@ONLY
)

configure_file (
	"${PROJECT_SOURCE_DIR}/rules.mk.in"
	"${PROJECT_SOURCE_DIR}/rules.mk"
	@ONLY
)

if (ADD_PACKAGE_LINK)
	execute_process(
		COMMAND bash -c "ln -s lfmerge-fdo lfmerge-fdo-@DatabaseVersion@"
		WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/../.."
	)
endif (ADD_PACKAGE_LINK)
