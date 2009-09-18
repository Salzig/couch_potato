require File.dirname(__FILE__) + '/spec_helper'

describe CouchPotato, 'attachments' do
  it "should persist an attachment" do
    comment = Comment.new :title => 'nil'
    comment._attachments = {'body' => {'data' => 'a useful comment', 'content_type' => 'text/plain'}}
    CouchPotato.database.save! comment
    CouchPotato.couchrest_database.fetch_attachment(comment.to_hash, 'body').to_s.should == 'a useful comment'
  end
  
  it "should give me information about the attachments of a document" do
    comment = Comment.new :title => 'nil'
    comment._attachments = {'body' => {'data' => 'a useful comment', 'content_type' => 'text/plain'}}
    CouchPotato.database.save! comment
    comment_reloaded = CouchPotato.database.load comment.id
    comment_reloaded._attachments.should == {"body" => {"content_type" => "text/plain", "stub" => true, "length" => 16}}
  end
  
end
