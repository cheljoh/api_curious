require 'rails_helper'

describe TumblrService do

  it "returns blog info" do
    VCR.use_cassette("tumblr_service#info") do
      service = TumblrService.new("cheljoh")
      info = service.info
      expect(info[:title]).to eq("Fun Times")
      expect(info[:name]).to eq("cheljoh")
      expect(info[:total_posts]).to eq(4)
    end
  end

  it "returns blog posts" do
    VCR.use_cassette("tumblr_service#posts") do
      service = TumblrService.new("cheljoh")
      post1 = service.posts.first
      post2 = service.posts.last
      expect(post1[:title]).to eq("Another one")
      expect(post1[:body]).to eq("<p>Look at this wow so cool.</p>")
      expect(post2[:title]).to eq("Heyyyyy")
      expect(post2[:body]).to eq("<p>Testing for an app whooooooo</p>")
    end
  end

  it "returns photo summaries" do
    VCR.use_cassette("tumblr_service#photos") do
      service = TumblrService.new("cheljoh")
      photo1 = service.photos.first
      photo2 = service.photos.last
      expect(photo1[:summary]).to eq("unicat dawwwwww")
      expect(photo2[:summary]).to eq("kawaii manatee! awwww")
    end
  end

  it "returns avatar" do
    VCR.use_cassette("tumblr_service#avatar") do
      service = TumblrService.new("cheljoh")
      avatar = service.avatar
      expect(avatar).to eq(avatar_string)
    end
  end

  it "returns following" do
    user = User.create(uid: "horace", name: "horace", oauth_token: ENV["OAUTH_TOKEN"], oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])
    VCR.use_cassette("tumblr_service#following") do
      service = TumblrService.new("cheljoh")
      service.following(user)
    end
  end

  def avatar_string
    "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAALN0lEQVR4Ae1be0yUVxb/zQzzYmBQRJCHIj7QVdFYCcaIq6V2Y7XRbuKrTeMfGjUaa5q229r+Vw1r12TdNavp7naT0kfW+IqGxUdFKlitKW0threIIG8oCMz7PXvPHb5h0BmYGYbBRk+C353vO/c8fvfec8+536fo0aNHTjzDJH6GfeeuPwfg+Qx4xhF4vgSe8QmAiLECoKenB/fv30dDQwNaW1vR0dGBrq4uaDQa9Pf3w2azwWAwQCqVQqlUQqVS8T9qx8XFYcqUKUhOTkZaWhpmzZqFSZMmjYmpolDlAY2NjSgtLcWdO3dQXl6Ozs7OkBpMgGRkZGDJkiXIysrCtGnTQiJ/VADU1NTgypUrKCkpQXNz8xCD5Gxkp0+KQapSikSRBfFsrsXJJYiRShAVIYZCLBrCb3I4obM50G+1o9tsR5cNaHdK0WCw4uGjflis7IYHEQAvvvgi1qxZg9mzZ3s8CawZMABmsxkFBQU4c+YMn+KCOqVcjoykyZgvs2O+3IE50TJEiIY6KfAGerU5najVWlBuEqPCLEJF+68wW6xuMXPnzsWWLVs4GLSkAiG/AbBarTh37hzy8vLQ3d3NdchkUiyfmYqVCgsWK52QPTaqgRgSCK+ZzZafDcANkxTf1zeDbCOiZbJjxw6sX78eEonEL5F+AUBr+uOPPwatc6KESbHYMDMRq8UaREeEZpS54CD+6WfLptCuxoX7bejp7eMSaEkcPHjQr6UxIgAXLlzA4cOHYbfbEaOOxraMNPwBvSGb3kH47LWLhc2Ki/YY/LfiAXR6A2QyGQ4dOoSXXnrJK79wc1gArl27hg8//BBOtgaXz0vH/olWqEV2oe9Tee1xiPH3bjF+uveAL4MTJ04gMzPTp60+AXA4HFi7di1f769mzMYetRlhWuI+jfX3AZsMONIlQkndQ74MTp486bOrz1SY5QfuYLdeqvvNOE+e0kC9ojByp+vr6/kM9oWATwAoGxP216MNWmhYsPmtUKfJhuMNGm7u8uXLIRpmO/YJAPV+7733eOeaXh32lj9Cya8GPM3HR3ZmXEG7FvvKu9GiM/FA+Pbbbw87bsMCQGnnunXruIAeFlk/qe3GnopeFHbqYaWF9pSQns1Ocnx3eQ9O1PdCZ7Zwy7Zt24bU1NRhrfQZBIVeFAs2btzIixiaSrQjEKnkMmTHRWLlRBkyYuRh3xYpGbrbZ0JJrwW3ftXDzIorT0pJScGpU6cgZxnqcDQiANT5/PnzyM3NRWSUGtP/uAfOmpuo/fk2aKcgUkgjkDFRhUUqEeap5UiLlEEhCW2CZLQ7UK+zolZnxi86B8p79bDYBrfk+Fg1stMjcf6HDjZIwLFjx0DrfyTyCwBylFJMyginr3gVilf2IkLbhaj6W+gs+w6NdbXumUEKaaakRCuRphBjikyMyfII9ifhxVA0K4RUEjHkDCChVqBc38wWsIE5qWXTmRdDVBCZbehk1wazEy1a4xAdpCdapUD23AlYO1OPZalO/OmCCdfrbMjJycGRI0eIZUTyCwCSUldXhzfffJONuhNpe49ClpzuFq4waxD1sBQ3847ye2IGgGNgqbiZQtAghxekTsCiBCuyEg1YlCwBw5LTjXob9p81ITIykhdqCQkJfmn0+0CEtsTXX38dX3/9NfSXP4VsB3N2YHsxydUwpa9GysyLaKmvxZENCkybKML9bgea9ZFo1SnRoXWih03hPjaF9QYTTAOBSrBSGhEBVaQS6igF1GwJxamlSIoGElVmTI/SYmasA4kxYoigG+gyWOyYWC30lyJXDNi1axf8dZ4E+Q0AMZPwwsJCdD6oRdQv30D6whq67abYF3I4AJfqVTi61oT0eBoeisiuqOxmhIw1Ze4tdTBaUIClBMaVxAzyU8v3hvWf2xa09tr4yRENUiDkW6oXKTS93n33Xf6k45s82A2uZENgNaavQAQbyZs1feg3unYL4Zm3Kzk+6Lw3jpHvNfQ48EWpjccdqlv8LYMFyQEBQJ0owGRnZ0Ov1cBe/KUgh18lqglIzcjkpzeXa4c8GpMfBPHha1ZYWfCkM4BFixYFrCdgAEjD+++/D4VCgYZbl2FrqRmiVJqRw3/nV/s+malnseHML1Y09Q6fXo/Ed7nKhtJGK2JiYvDWW28NscPfH0EBkJSUxLdFSop0LCCyrcGtzzkrC0pVFKqa+ngQdD8YaJBTW/MMyL1qxpbPjWjrH+zryfs4X+tjfDq2Nf71uivwkfMTJkzw7O53OygASDptiXRk3dFQB0fZFbdCUYQMqZkr+e/86idj7J1mO5uyLnaj1YmyVu8APMHXMpTvHzesbFexYeHChdiwYYNbf6CNoAGgw8cDBw7w4NN65QvY9a7jKDLAOtcFwMVKK8sHhpq0dLoESqkr9KkVImROHdzOPDk9+aLlIizx4KvqYEuozMoDHgW+4ao9T5ne2kEDQMKEYkmv08J5Pc8tXzptPmITEtHTb8T3DYPpKjFMmyjGuR1K5L6qwJntkYiP9r4PPM43Re3iI0BzC208Idu6dau7ZHcrD7AxKgBI1/79+6FWq1F/uxCOliqXepYgTV6Sw9v5NbTnD6UkltCsmx+BBB/OC9wCn+A83T/LRr6yjb1niI/H7t27Bdagr6MGIDY2lkdgCojaS/+E0+EacdvcVdyo4hodNKbH1kGQ5vbonTj+nUv+O++8w9PeIEW5u40aAJJEQYheW7U33ofk7mUuXBqXjKTZ81hOYMeV6qHLwK09wMbRYis0RhuWLVuG1atXB9jbO3tIABCLxfjoo494UGq89CUcukdcm3KhsAx85wTezXry7o9NdlyqtPBTng8++OBJhiDvhAQA0i0USwa9DqLiPG6O+HfZLDWWoqJJC0pZgyXaNg8XOXidv337dtBhR6goZACQQUIldu92EcQtlZBEqpG8MIvbml8ZfBz46kcrHnSZMXXqVNAxVygppAAIxRIFxN6Ln/KAKJrvWgYXq51P5AT+ONKuceLft10ZH+Ud9MYnlBRSAMgwoVhqf/gA8rICyGdn8qO0LnZ+d7sx8GD4SZEdJosdL7/8MpYuXRpK37mskANAUoViqe7SVxCZNIh/YSVXll8VmLpidrxVcs/EvxwRynAuKIT/BGaRn4qFYsnIPoERFX8O57xVvOf1WhO0rIjxh/gpz3UX7549e/hnM/70C5RnTAAgI4Riqfr7bxEjsWHilBSeE1ytca3nkQz9F1v37b1mzJkzB5s2bRqJPejnYwaAZ7HU/b9Pocr4PTcyv8p78ePpwQNWMn9VagHlF8Gc8njKGqk9ZgCQYqFYamtqRKRFw6u2u00G9s2P75yAJv2fvwVs7JTntddew4IFC0byYVTPxxQAskwolpp+KELUpARubH6F793gYqUNPzUYQDXGvn37RuWcP53HHAChWDKZjND1dHGbCqrZIZKXWEhF099KXA8E4PxxYjQ8Yw4AGScUS06na+p39pnxg5ec4PhN9u5Aa8bixYvdL2VH45w/fcMCgGexJBhVUDV0ClS023H2jpEfq4/2lEfQ4c81LACQIUKxJBhVdM8K/UBOwE95ilyv09544w3MmDFDYBvza9gAIE+EYonalN5erXXlBKfL7KhuNSAxMRE7d+6kx2GjsAIgFEuCd/mVQLfHKQ+lu/SxdDgprACQY0KxRO2yZjMOFNihM1qwYsUKrFq1im6Hlfx+PR5Kq9ra2rB582aYTCYult4ynT59GlRDhJvCPgPIQaFYEpyljy/Gw3nSPy4zgBTTB8579+7l188++4z/xwm6H24aNwDC7agvfeOyBHwZMx73nwMwHqg/TTqfz4CnaTTGw5Znfgb8Hx1AcqiLGQNVAAAAAElFTkSuQmCC"
  end

end
