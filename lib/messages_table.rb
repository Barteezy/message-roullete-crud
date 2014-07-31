class MessagesTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def all
    insert_user_sql = <<-SQL
    SELECT * FROM messages
    SQL

    @database_connection.sql(insert_user_sql)
  end

  def create(message)
    insert_user_sql = <<-SQL
    INSERT into messages (message)
    VALUES ('#{message}')
    SQL
    @database_connection.sql(insert_user_sql).first
  end

  def find(id)
    insert_user_sql = <<-SQL
    SELECT * FROM messages WHERE id = '#{id}'
    SQL
    @database_connection.sql(insert_user_sql).first
  end

  def update(message,id)
    find_sql = <<-SQL
    UPDATE messages SET message='#{message}'
    WHERE id = '#{id}'
    SQL
    @database_connection.sql(find_sql)

  end

  def delete(id)
    find_sql = <<-SQL
    DELETE FROM messages
    WHERE id = '#{id}'
    SQL
    @database_connection.sql(find_sql)
  end

end