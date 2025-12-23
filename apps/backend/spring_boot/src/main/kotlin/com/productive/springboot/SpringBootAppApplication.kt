package com.productive.springboot

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class SpringBootAppApplication

fun main(args: Array<String>) {
	runApplication<SpringBootAppApplication>(*args)
}
