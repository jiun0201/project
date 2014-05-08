library(rCharts)
library(RCurl)

d<- read.csv("Wholesale customers data.csv", header=T, sep=",")

d$newchannel <- "Horeca"
d$newchannel[d$Channel=="2"] <-"Retail"
d$newregion <- "Lisbon"
d$newregion[d$Region=="2"] <-"Oporto"
d$newregion[d$Region=="3"] <-"Other Region"

d <-d[,c(3,4,5,6,9,10)]

ScatterMatrix = setRefClass('ScatterMatrix', contains = 'rCharts', 
                            methods = list(initialize = function(){callSuper()
                            LIB <<- get_lib("http://benjh33.github.io/rchart_plugins/scatter_matrix")
                            lib <<- "scatter_matrix"
                            templates$script <<- '<script type="text/javascript">
                                                  function draw{{chartId}}(){
                                                  var params = {{{ chartParams }}}
                                                  var scatter = {{{ scatter }}}.id(params.id)
                                                  if(!params.data){d3.json(params.data_file, 
                                                  function(error, d) {d3.select("#" + params.id)
                                                  .datum(d)
                                                  .call(scatter)});
                                                  } else {d3.select("#" + params.id)
                                                  .datum(params.data)
                                                  .call(scatter)}
                                                  return scatter;};
                                                  $(document).ready(function(){
                                                  draw{{chartId}}()});
                                                  </script>'},
                            getPayload = function(chartId){
                            skip = c('data', 'id', 'dom')
                            scatter = toChain(params[!(names(params) %in% skip)], 
                                      "d3.scatter_matrix()")
                            chartParams = RJSONIO::toJSON(params[skip])
                            list(scatter = scatter, chartParams = chartParams,
                            chartId = chartId, lib = basename(lib), liburl = LIB$url
                            )
                            }
                            ))

chart <- ScatterMatrix$new()

chart$set(group='newchannel',data = d,
#   data_file = dname, # use a data_file or data argument, not both
          filter = "newregion",
          height=700,
          width=700,
          opacity = 0.4,
          point_size = 4,
          margin = 10,
          id = chart$params$dom)

chart
