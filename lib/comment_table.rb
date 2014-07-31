class CommentsTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(comment, message_id)
    insert_user_sql = <<-SQL
    INSERT into comments (comment, message_id)
    VALUES ('#{comment}', '#{message_id}')
    SQL
    @database_connection.sql(insert_user_sql).first
  end

  def all
    insert_user_sql = <<-SQL
    SELECT * FROM comments
    SQL

    @database_connection.sql(insert_user_sql)
  end

end