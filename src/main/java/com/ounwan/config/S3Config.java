package com.ounwan.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

@Configuration
public class S3Config {
	private static final String ACCESS_KEY = "00";
	private static final String SECRET_KEY = "00";
	private static final String REGION = "ap-northeast-2";

	@Bean
	public AmazonS3Client amazonS3Client() {
		BasicAWSCredentials credentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);

		return (AmazonS3Client) AmazonS3ClientBuilder.standard().withRegion(REGION)
				.withCredentials(new AWSStaticCredentialsProvider(credentials)).build();
	}
}
