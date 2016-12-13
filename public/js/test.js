
function test(data) {
var m = [80, 80, 80, 80]; // margins
		var w = 1000 - m[1] - m[3]; // width
		var h = 400 - m[0] - m[2]; // height

		// create a simple data array that we'll plot with a line (this array represents only the Y values, X will just be the index location)
		// X scale will fit all values from data[] within pixels 0-w
		var xScale = d3.scale.linear().domain([1386604800000, 1386608400000]).range([0, w]);
		// Y scale will fit values from 0-10 within pixels h-0 (Note the inverted domain for the y-scale: bigger is up!)
		var yScale = d3.scale.linear().domain([0, 20]).range([h, 0]);
			// automatically determining max range can work something like this
			// var y = d3.scale.linear().domain([0, d3.max(data)]).range([h, 0]);


			var lineGen = d3.svg.line()
			  .x(function(d) {
					console.log(d.timestamp);
			    return xScale(d.timestamp);
			  })
			  .y(function(d) {
					console.log(d.value);
			    return yScale(d.value);
			  });

			// Add an SVG element with the desired dimensions and margin.
			var graph = d3.select("#graph").append("svg:svg")
			      .attr("width", w + m[1] + m[3])
			      .attr("height", h + m[0] + m[2])
			    .append("svg:g")
			      .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

			// create yAxis
			var xAxis = d3.svg.axis().scale(xScale);
			// Add the x-axis.
			graph.append("svg:g")
			      .attr("class", "x axis")
			      .attr("transform", "translate(0," + h + ")")
			      .call(xAxis);


			// create left yAxis
			var yAxisLeft = d3.svg.axis().scale(yScale).ticks(4).orient("left");
			// Add the y-axis to the left
			graph.append("svg:g")
			      .attr("class", "y axis")
			      .attr("transform", "translate(0,0)")
			      .call(yAxisLeft);

  			// Add the line by appending an svg:path element with the data line we created above
			// do this AFTER the axes above so that the line is above the tick-lines
  			graph.append("svg:path").attr("d", lineGen(data))
  .attr('stroke', 'green')
  .attr('stroke-width', 2)
  .attr('fill', 'none');



}
