import React, { useRef, useEffect } from 'react';
import * as d3 from 'd3';

const BarChart = ({ data }) => {
    const chartRef = useRef();

    useEffect(() => {
        if (data && data.length) {
            d3.select(chartRef.current).select("svg").remove();

            const margin = { top: 30, right: 30, bottom: 70, left: 60 },
                width = 400 - margin.left - margin.right,
                height = 280 - margin.top - margin.bottom;

            const svg = d3.select(chartRef.current)
                .append("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr("transform", `translate(${margin.left},${margin.top})`);

            const x = d3.scaleBand()
                .range([0, width])
                .domain(data.map(d => d.exam_name))
                .padding(0.6); // Adjust the padding to control bar width

            const xAxis = svg.append("g")
                .attr("transform", `translate(0,${height})`)
                .call(d3.axisBottom(x));

            xAxis.selectAll("text")
                .attr("transform", "translate(-10,0)rotate(-45)")
                .style("text-anchor", "end");

            const y = d3.scaleLinear()
                .domain([0, 10])
                .range([height, 0]);

            const yAxis = svg.append("g").call(d3.axisLeft(y));

            yAxis.append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 15 - margin.left)
                .attr("x", 0 - (height / 2))
                .attr("dy", "1em")
                .style("text-anchor", "middle")
                .text("Correct Answers");

            // Grid lines
            svg.append('g')
                .attr('class', 'grid')
                .call(d3.axisLeft(y).tickSize(-width).tickFormat(''));

            svg.append("text")
                .attr("x", (width / 2))             
                .attr("y", 0 - (margin.top / 2))
                .attr("text-anchor", "middle")  
                .style("font-size", "16px") 
                .style("text-decoration", "underline")  
                .text("Number of Correct Answers vs Exam Name");

            // Bars with transition
            svg.selectAll("bars")
                .data(data)
                .enter()
                .append("rect")
                .attr("x", d => x(d.exam_name))
                .attr("y", height)
                .attr("width", x.bandwidth())
                .attr("fill", "#6baed6")
                .transition()
                .duration(800)
                .attr("y", d => y(d.correct_answers))
                .attr("height", d => height - y(d.correct_answers));

            // Hover effect
            svg.selectAll("rect")
                .on("mouseover", function() {
                    d3.select(this)
                        .transition()
                        .duration(300)
                        .attr("fill", "#3182bd");
                })
                .on("mouseout", function() {
                    d3.select(this)
                        .transition()
                        .duration(300)
                        .attr("fill", "#6baed6");
                });

            // Bar labels
            svg.selectAll("text.bar")
                .data(data)
                .enter()
                .append("text")
                .attr("class", "bar")
                .attr("text-anchor", "middle")
                .attr("x", d => x(d.exam_name) + x.bandwidth() / 2)
                .attr("y", d => y(d.correct_answers) - 5)
                .text(d => d.correct_answers);

            

        }
    }, [data]);

    return <div ref={chartRef} />;
};

export default BarChart;
