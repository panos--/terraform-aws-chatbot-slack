Resources:
  chatbottest:
    Type: AWS::Chatbot::SlackChannelConfiguration
    Properties:
      ConfigurationName: ${config_name}
      IamRoleArn: ${iam_role_arn}
      SlackChannelId: ${slack_channel_id}
      SlackWorkspaceId: ${slack_workspace_id}
      LoggingLevel: ${log_level}
      SnsTopicArns:
        - ${sns_topic_arn}
